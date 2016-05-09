class HumanResources::CompensationAndBenefits::LoansController < HumanResources::CompensationAndBenefitsController

  def index
    query = generic_index_aggregated_queries('loans','loans.created_at')
    begin
      @loans = Loan.where("loans.borrower_name LIKE ?",
                          "%#{query[:search_field]}%")
                   .order(query[:order_parameter] + ' ' + query[:order_orientation])
      @loans = Kaminari.paginate_array(@loans).page(params[:page]).per(query[:current_limit])
    rescue => ex
      flash[:general_flash_notification] = "Error has Occured" + ex.to_s
    end
    render 'human_resources/compensation_and_benefits/loans/index'
  end

  def search_suggestions
    loans = Loan.pluck("loans.borrower_name")
    direct = "{\"query\": \"Unit\",\"suggestions\":" + loans.uniq.to_s + "}" # default format for plugin
    respond_to do |format|
      format.all { render :text => direct}
    end
  end


  def initialize_form
    initialize_form_variables('LOAN',
                              'human_resources/compensation_and_benefits/loans/loan_form',
                              'loan')
    initialize_employee_selection
  end

  def new
    initialize_form
    @selected_loan = Loan.new
    generic_bicolumn_form_with_employee_selection(@selected_loan)
  end

  def edit
    initialize_form
    @selected_loan = Loan.find(params[:id])
    generic_bicolumn_form_with_employee_selection(@selected_loan)
  end

  def process_loan_form(loan)
    begin
      loan.loan_type = params[:loan][:loan_type]
      loan.pagibig_employer_id_number = '123456'
      loan.employer_name = 'James Pe'
      loan.employer_business_name = 'NorthSea Parts'
      loan.employer_business_address = 'Cainta Rizal'
      loan.employee_id = params[:loan][:employee_id]
      loan.borrower_name = Employee.find(params[:loan][:employee_id]).actor.name
      loan.loan_value = params[:loan][:loan_value]
      loan.loan_remaining = params[:loan][:loan_value]
      loan.collection_period_from = params[:loan][:collection_period_from]
      loan.collection_period_to = params[:loan][:collection_period_to]
      loan.monthly_installment = params[:loan][:monthly_installment]
      loan.remark = params[:loan][:remark]
      loan.save!
      flash[:general_flash_notification_type] = 'affirmative'
    rescue => ex
      puts ex
      flash[:general_flash_notification] = 'Error Occurred. Please contact Administrator.'
    end
    redirect_to :action => 'index'
  end

  def delete
    generic_delete_model(Loan, controller_name)
  end

  def update
    loan = Loan.find(params[:loan][:id])
    flash[:general_flash_notification] = 'Employee Loan Updated'
    process_loan_form(loan)
  end

  def create
    loan = Loan.new()
    flash[:general_flash_notification] = 'Employee Loan Created'
    process_loan_form(loan)
  end

  def show
    @selected_loan = Loan.find(params[:id])
    @specific_loan_payments = LoanPayment.where("loan_id = ?", @selected_loan[:id] ).order("payment_date DESC")
    render 'human_resources/compensation_and_benefits/loans/show'
  end

end