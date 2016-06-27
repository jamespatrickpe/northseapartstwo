class AccountingAndFinance::ExpensesController < AccountingAndFinanceController

  def index

    #Process Form
    params.has_key?("/accounting_and_finance/expenses") ? expense_list_interval = (params["/accounting_and_finance/expenses"][:expense_list_interval]).to_s.downcase : expense_list_interval = nil
    case expense_list_interval
      when 'second'
        interval_format = '%Y/%m/%d %H:%M:%S'
        interval = 1.second
      when 'minute'
        interval_format = '%Y/%m/%d %H:%M'
        interval = 1.minute
      when 'hour'
        interval_format = '%Y/%m/%d %H'
        interval = 1.hour
      when 'day'
        interval_format = '%Y/%m/%d'
        interval = 1.day
      when 'month'
        interval_format = '%Y/%m'
        interval = 1.month
      when 'year'
        interval_format = '%Y'
        interval = 1.year
      else
        interval_format = '%Y/%m'
        interval = 1.month
    end
    @interval_format = interval_format
    @interval = interval

    # Overview Panels
    @overview_panels = [
        [accounting_and_finance_expenses_expense_categories_path,'Expense Category'],
        [accounting_and_finance_expenses_expense_entries_path,'Expense Entries']
    ]

  end

end
