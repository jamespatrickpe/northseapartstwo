class AccountingAndFinance::Expenses::ExpenseCategoriesController < AccountingAndFinance::ExpensesController

  def index
    initialize_generic_index(ExpenseCategory, 'Types of Expenses')
  end

  def search_suggestions
    generic_index_search_suggestions(ExpenseCategory)
  end

  def new
    set_new_edit(ExpenseCategory)
  end

  def edit
    set_new_edit(ExpenseCategory)
  end

  def show
    edit
  end

  def delete
    generic_delete(ExpenseCategory)
  end

  def process_form(expense_category, current_params, wizard_mode = nil)
    begin
      expense_category[:remark] = current_params[:remark]
      expense_category[:name] = current_params[:name]
      expense_category[:parent_expense_id] = current_params[:parent_expense_id]
      expense_category.save!
      set_process_notification unless wizard_mode
    rescue => ex
      index_error(ex, wizard_mode)
    end
    form_completion_redirect(wizard_mode)
  end

  def create
    process_form(ExpenseCategory.new(), params[controller_path])
  end

  def update
    process_form(ExpenseCategory.find(params[controller_path][:id]), params[controller_path])
  end

end
