module AccountingAndFinance::ExpensesHelper

  def display_children(node)
    render :template => 'accounting_and_finance/expenses/expense_list_item', :locals => {:node => node}
  end

  def get_expense_entries(start_period, end_period, category_id)

    query = Sunspot.search(ExpenseEntry) do
      with(:datetime_of_implementation).between(start_period..end_period)
      with(:expense_category_id).equal_to(category_id)
    end

    query.results

  end

end
