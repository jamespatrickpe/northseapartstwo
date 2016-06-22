module AccountingAndFinance::ExpensesHelper

  def display_children(node)
    render :template => 'accounting_and_finance/expenses/expense_list_item', :locals => {:node => node}
  end

end
