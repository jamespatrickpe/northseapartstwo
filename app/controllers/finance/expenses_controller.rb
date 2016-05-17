class Finance::ExpensesController < FinanceController

  def index
    query = generic_index_aggregated_queries('expenses','expenses.created_at')
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

  def initialize_form
    initialize_form_variables('EXPENSES',
                              'finance/expenses/expense_form',
                              'expense')
    initialize_employee_selection
  end

  def search_suggestions
    expenses = Expense
                   .where("expense.access_id LIKE ?","%#{params[:query]}%")
                   .pluck("expense.access_id")
    direct = "{\"query\": \"Unit\",\"suggestions\":[" + expenses.to_s.gsub!('[', '').gsub!(']', '') + "]}"
    respond_to do |format|
      format.all { render :text => direct}
    end
  end

  def new
    initialize_form
    @selected_expense = Expense.new
    @actors1 = Actor.all()
    @actors2 = Branch.all()

    generic_form_main(@selected_expense)
  end

  def edit
    initialize_form
    @selected_expense = Expense.find(params[:id])
    @actorsInvolved ||= []

    # @expense_actor_rel = ExpensesActor.find_by_expense_id(params[:id])
    @expense_actor_rel = ExpensesActor.where("expenses_actors.expense_id = ?", "#{params[:id]}")

    involvedActorObjects ||= []
    involvedBranchObjects ||= []

    @expense_actor_rel.each do |ea|
      if Actor.exists?(ea[:system_actor_id])
        involvedActorObjects.push(Actor.find(ea[:system_actor_id]))
      else
        puts 'ID in use does not belong to an Actor'
      end
    end

    @expense_actor_rel.each do |ea|
      if Branch.exists?(ea[:system_actor_id])
        involvedBranchObjects.push(Branch.find(ea[:system_actor_id]))
      else
        puts 'ID in use does not belong to a Branch'
      end
    end

    @actorsInvolved = involvedActorObjects + involvedBranchObjects

    @actorsInvolved.compact.uniq!

    @actors1 = Actor.all()
    @actors2 = Branch.all()

    generic_form_main(@selected_expense)
  end

  def delete

    expense_to_be_deleted = Expense.find(params[:id])
    flash[:general_flash_notification] = 'Expense has been deleted from database'
    flash[:general_flash_notification_type] = 'affirmative'

    # deletes all related actors with the expense before deleting the actual expense object
    mapped_expense_actors = ExpensesActor.where("expenses_actors.expense_id = ?", "#{params[:id]}")
    mapped_expense_actors.each do |a|
      a.destroy
    end

    expense_to_be_deleted.destroy
    redirect_to :action => 'index'
  end

  def process_expenses_form(myExpense)

    begin
      # initially creates the new expense and inserts it into db
      myExpense[:amount] = params[:expense][:amount]
      myExpense[:category] = params[:expense][:category]
      myExpense[:physical_id] = params[:expense][:physical_id]
      myExpense[:remark] = params[:expense][:remark]
      myExpense[:date_of_implementation] = params[:expense][:date_of_implementation]
      myExpense.save!

      # after creating the new expense, iterate through all the actors involved and maps them with the expense
      actorsInvolved = params[:expense][:expenseactors]
      actorsInvolved.each_with_index do |p , index|
        actor = ExpensesActor.new
        actor[:system_actor_id] = actorsInvolved.values[index]
        actor[:expense_id] = myExpense.id
        actor.save!
      end

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