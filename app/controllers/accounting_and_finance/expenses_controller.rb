class AccountingAndFinance::ExpensesController < AccountingAndFinanceController

  def index

    #Process Form
    expense_list_interval = (params[:expense_list_interval])
    interval = 1.day
    case expense_list_interval
      when "second"
        expense_list_interval = '%Y/%m/%d %T'
        interval = 1.second
      when "minute"
        expense_list_interval = '%Y/%m/%d %H:%M'
        interval = 1.minute
      when "hour"
        expense_list_interval = '%Y/%m/%d %H'
        interval = 1.hour
      when "day"
        expense_list_interval = '%Y/%m/%d'
        interval = 1.day
      when "week"
        expense_list_interval = '%G/W%V'
        interval = 1.week
      when "month"
        expense_list_interval = '%Y/%m'
        interval = 1.month
      when "year"
        expense_list_interval = '%Y'
        interval = 1.year
      else
        expense_list_interval = '%Y/%m/%d %T'
    end

    @interval = interval

    # Overview Panels
    @overview_panels = [
        [accounting_and_finance_expenses_expense_categories_path,'Expense Category'],
        [accounting_and_finance_expenses_expense_entries_path,'Expense Entries']
    ]

  end

end
