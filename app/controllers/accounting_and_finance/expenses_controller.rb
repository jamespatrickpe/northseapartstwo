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

end
