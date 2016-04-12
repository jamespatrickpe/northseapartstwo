class HumanResources::CompensationAndBenefits::LoanPaymentsController < HumanResources::CompensationAndBenefitsController


  class LoanPaymentLog
    attr_accessor :before, :after
  end

  def index
    query = generic_table_aggregated_queries('loan_payments','loan_payments.created_at')
    begin
      @loan_payments = LoanPayment.where("loan_payments.loan_id LIKE ?",
                                         "%#{query[:search_field]}%")
                           .order(query[:order_parameter] + ' ' + query[:order_orientation])
      @loan_payments = Kaminari.paginate_array(@loan_payments).page(params[:page]).per(query[:current_limit])
    rescue => ex
      flash[:general_flash_notification] = "Error has Occured" + ex.to_s
    end
    render 'human_resources/compensation_and_benefits/loan_payments/index'
  end

  def search_suggestions
    loan_payments = LoanPayment.pluck("loan_payments.loan_id")
    direct = "{\"query\": \"Unit\",\"suggestions\":" + loan_payments.uniq.to_s + "}" # default format for plugin
    respond_to do |format|
      format.all { render :text => direct}
    end
  end


  def initialize_form
    initialize_form_variables('LOAN PAYMENT',
                              'human_resources/compensation_and_benefits/loan_payments/loan_payment_form',
                              'loan_payment')
    initialize_employee_selection
  end

  def new
    initialize_form
    @selected_loan_payment = LoanPayment.new
    @loans = Loan.all.order(borrower_name: :asc)
    generic_singlecolumn_form(@selected_loan_payment)
  end

  def edit
    initialize_form
    @selected_loan_payment = LoanPayment.find(params[:id])
    generic_singlecolumn_form(@selected_loan_payment)
  end

  def process_loan_payment_form(loan_payment)
    begin
      loan_payment.loan_id = params[:loan_payment][:loan_id]
      loan_payment.mid_number = params[:loan_payment][:mid_number]
      loan_payment.payment_amount = params[:loan_payment][:payment_amount]
      loan_payment.payment_date = params[:loan_payment][:payment_date]
      loan_payment.loan_amount_before_payment = process_payment(params[:loan_payment][:loan_id], params[:loan_payment][:payment_amount]).before
      loan_payment.loan_amount_after_payment = process_payment(params[:loan_payment][:loan_id], params[:loan_payment][:payment_amount]).after
      loan_payment.remark = params[:loan_payment][:remark]

      # Update parent Loan object
      parent_loan = Loan.find(params[:loan_payment][:loan_id])
      parent_loan.loan_remaining = loan_payment.loan_amount_after_payment
      parent_loan.save!

      loan_payment.save!

      flash[:general_flash_notification_type] = 'affirmative'
    rescue => ex
      puts ex
      flash[:general_flash_notification] = 'Error Occurred. Please contact Administrator.'
    end
    redirect_to :action => 'index'
  end

  def delete
    generic_delete_model(LoanPayment, controller_name)
  end

  def update
    loan_payment = LoanPayment.find(params[:loan_payment][:id])
    flash[:general_flash_notification] = 'Loan Payment Updated'
    process_loan_payment_form(loan_payment)
  end

  def create
    loan_payment = LoanPayment.new()
    flash[:general_flash_notification] = 'Employee Loan Payment successfully created'
    process_loan_payment_form(loan_payment)
  end

  def process_payment(loan_id, payment_amount)

    result_payment_log = LoanPaymentLog.new
    loan_to_be_paid = Loan.find(loan_id)

    before_payment = loan_to_be_paid.loan_value

    # Check if initial payment
    if loan_to_be_paid[:loan_value] == loan_to_be_paid[:loan_remaining]
      after_payment = loan_to_be_paid.loan_value.to_f - payment_amount.to_f
    else
      after_payment = loan_to_be_paid.loan_remaining.to_f - payment_amount.to_f
    end

    result_payment_log.before = before_payment
    result_payment_log.after = after_payment

    return result_payment_log

  end


end