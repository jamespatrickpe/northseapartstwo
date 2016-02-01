class Finance::ExpensesController < FinanceController

  def index
    query = generic_table_aggregated_queries('expenses','expenses.created_at')
    begin
      @expenses = Expense
                         .where("expenses.amount LIKE ? OR " +
                                    "expenses.category LIKE ? ",
                                "%#{query[:search_field]}%",
                                "%#{query[:search_field]}%")
                         .order(query[:order_parameter] + ' ' + query[:order_orientation])
      @expenses = Kaminari.paginate_array(@expenses).page(params[:page]).per(query[:current_limit])
    rescue => ex
      puts ex
      flash[:general_flash_notification] = "Error has Occured" + ex.to_s
    end
    render '/finance/expenses/index'
  end

  def search_suggestions
    expenses = Expenses
                      .where("expense.access_id LIKE ?","%#{params[:query]}%")
                      .pluck("expense.access_id")
    direct = "{\"query\": \"Unit\",\"suggestions\":[" + expenses.to_s.gsub!('[', '').gsub!(']', '') + "]}"
    respond_to do |format|
      format.all { render :text => direct}
    end
  end

  def new
    @selected_expense = Expense.new
    @actors = Actor.all()
    render 'finance/expenses/expense_form'
  end

  def edit
    @selected_expense = Expense.find(params[:id])
    @actors = Actor.all()
    render 'finance/expenses/expense_form'
  end

  def delete
    expense_to_be_deleted = Expense.find(params[:id])
    flash[:general_flash_notification] = 'Expense has been deleted from database'
    flash[:general_flash_notification_type] = 'affirmative'
    expense_to_be_deleted.destroy
    redirect_to :action => 'index'
  end

  def process_expenses_form(myExpense)

    begin
      myExpense[:amount] = params[:expense][:amount]
      myExpense[:category] = params[:expense][:category]
      myExpense[:physical_id] = params[:expense][:physical_id]
      myExpense[:remark] = params[:expense][:remark]
      myExpense[:date_of_effectivity] = params[:expense][:date_of_effectivity]
      myExpense.save!

      flash[:general_flash_notification_type] = 'affirmative'
    rescue => ex
      puts ex
      flash[:general_flash_notification] = 'Error Occurred. Please contact Administrator.' + ex.to_s
    end
    redirect_to :action => 'index'
  end

  def create
    myExpense = Expense.new()
    flash[:general_flash_notification] = 'Expense Created!'
    process_expenses_form(myExpense)
  end

  def update
    myExpense = Expense.find(params[:expense][:id])
    flash[:general_flash_notification] = 'Expense Updated: ' + params[:expense][:id]
    process_expenses_form(myExpense)
  end

end