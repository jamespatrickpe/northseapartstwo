class AccountingAndFinanceController < ApplicationController

  layout "application_loggedin"

  def index

    @overview_panels = [
        [accounting_and_finance_expenses_path,'Expenses']
    ]

    generic_index_main('System-Wide Accounting and Finance Concerns')

  end

end
