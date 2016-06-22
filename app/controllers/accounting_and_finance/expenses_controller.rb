class AccountingAndFinance::ExpensesController < AccountingAndFinanceController

  def index

    @overview_panels = [
        [accounting_and_finance_expenses_expense_categories_path,'Expense Category'],
        [accounting_and_finance_expenses_expense_entries_path,'Expense Entries']
    ]

    @wizard_buttons =
        [
            # [accounting_and_finance_expenses_expense_entries_wizard(:setup_expense_entry),'Add Expense Entry']
        ]
  end

  def get_expense_entries(start_period, end_period, category_id)

    query = Sunspot.search(ExpenseEntry) do
      with(:datetime_of_implementation).between(start_period..end_period)
      with(:expense_category_id).equal_to(category_id)
    end
    query.results

  end

  def process_form
    start_period = (params[:start_period])
    end_period = (params[:end_period])
    expense_list_interval = (params[:expense_list_interval])

    case expense_list_interval
      when "second"
        expense_list_interval = '%Y/%m/%d %T'
      when "minute"
        expense_list_interval = '%Y/%m/%d %H:%M'
      when "hour"
        expense_list_interval = '%Y/%m/%d %H'
      when "day"
        expense_list_interval = '%Y/%m/%d'
      when "week"
        expense_list_interval = '%G/W%V'
      when "month"
        expense_list_interval = '%Y/%m'
      when "year"
        expense_list_interval = '%Y'
      else
        expense_list_interval = '%Y/%m/%d %T'
    end

    data_array = Array.new()
    params[:node_id].each do |key, value|
      unless (value == "none")


        current_values = get_expense_entries(start_period, end_period, key)

        data_array.push(current_values)
      end
    end

    puts data_array.inspect
    puts " ================ lala ==================="


    #redirect_to :action => 'index', :expense_list_interval => expense_list_interval
  end

end
