module AccountingAndFinance::ExpensesHelper

  def display_children(node)
    render :template => 'accounting_and_finance/expenses/expense_list_item', :locals => {:node => node}
  end

  def get_expense_entries(start_period, end_period, category_id)
    query = Sunspot.search(ExpenseEntry) do
      with(:datetime_of_implementation).between(start_period..end_period)
      with(:expense_category_id).equal_to(category_id)
      order_by(:datetime_of_implementation, :asc)
    end
    query.results
  end

  def get_expense_array(params, interval, interval_format)

    main_expenses = Array.new()

    # time array
    time_array = Array.new()
    time_array.push('x')
    current_time = Time.parse(params[:start_period])
    until current_time > Time.parse(params[:end_period])
      time_array.push( current_time.strftime(interval_format) )
      current_time += interval
    end
    main_expenses.push(time_array)

    if params.has_key?(:node_id)
      params[:node_id].each do |category_key, show_value|
        unless show_value == 'none'

          # category array
          category_array = Array.new()
          category_array.push( ExpenseCategory.find(category_key).name )
          current_time = Time.parse(params[:start_period])
          until current_time > Time.parse(params[:end_period])
            total = 0
            expense_category = ExpenseCategory.find(category_key)

            if expense_category.has_children?
              categories = expense_category.descendants
              categories.each do |category|
                expense_per_category = 0
                unless category.has_children?
                  entries = get_expense_entries(current_time,( current_time + interval),category.id)
                  unless entries == nil
                    entries.each do |entry|
                      expense_per_category += entry.amount.to_f
                    end
                  end
                end
                total += expense_per_category
              end
            else
              entries = get_expense_entries(current_time,( current_time + interval),category_key)
              unless entries == nil
                entries.each do |entry|
                  total += entry.amount.to_f
                end
              end
            end
            category_array.push(total)
            current_time += interval
          end
          main_expenses.push(category_array)
        end
      end
    end
    main_expenses

  end

end
