class AccountingAndFinance::Expenses::ExpenseEntriesController < AccountingAndFinance::ExpensesController

  def index
    initialize_generic_index(ExpenseEntry, 'An Entry of a Specific Expense')
  end

  def search_suggestions
    generic_index_search_suggestions(ExpenseEntry)
  end

  def new
    set_new_edit(ExpenseEntry)
  end

  def edit
    set_new_edit(ExpenseEntry)
  end

  def show
    edit
  end

  def delete
    generic_delete(ExpenseEntry)
  end

  def process_form(expense_entry, current_params, wizard_mode = nil)
    begin
      expense_entry[:remark] = current_params[:remark]
      expense_entry[:expense_category_id] = current_params[:expense_category_id]
      expense_entry[:system_account_id] = current_params[:system_account_id]
      expense_entry[:datetime_of_implementation] = current_params[:datetime_of_implementation]
      expense_entry[:amount] = current_params[:amount]
      expense_entry.save!
      set_process_notification unless wizard_mode
    rescue => ex
      index_error(ex, wizard_mode)
    end
    form_completion_redirect(wizard_mode)
  end

  def create
    process_form(ExpenseEntry.new(), params[controller_path])
  end

  def update
    process_form(ExpenseEntry.find(params[controller_path][:id]), params[controller_path])
  end


end
