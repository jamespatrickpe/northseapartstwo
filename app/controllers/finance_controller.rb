class FinanceController < ApplicationController

  include ApplicationHelper

  layout "application_loggedin"

  class ExpenseReport
    attr_accessor :report_total, :expense_category
    def initialize
      self.expense_category = []
    end
  end

  class ExpenseCategory
    attr_accessor :expense_type, :name
    attr_accessor :expense_total
    def initialize
      self.expense_type = []
    end
  end

  class ExpenseType
    attr_accessor :expenses, :name
    def initialize
      self.expenses = []
    end
  end

  def index
    generate_expense_report
    render 'finance/index'
  end

  def generate_expense_report

    @expenses = Expense.all()
    @full_expense_names = Expense.pluck('DISTINCT category')
    @expense_category = []
    @expense_types = []
    @full_expense_names.each do |c|
      @expense_category.push(c.split('.')[0])
      @expense_types.push(c.split('.')[1])
    end

    ############################################################################# STEP : 1
    # INITIAL STEP, PLUCK ALL CATEGORIES FROM THE LIST OF EXPENSES
    #
    # iterate all categories, for every major category, check every expense.
    # if expense has the same major category, push to its own array
    expense_report = ExpenseReport.new
    @expense_category.uniq.each do |c|

      # create new category object
      expense_category = ExpenseCategory.new
      expense_category.expense_total = 0

      # iterate all expense and check if it matches the plucked categories
      @expenses.each do |e|
        if c.to_s == e[:category].split('.')[0].to_s
          expense_category.name = c.to_s
          expense_category.expense_type.push(c.to_s)
        end
      end

      # push categories to the report object for the next step
      expense_report.expense_category.push(expense_category)
    end

    ############################################################################# STEP : 2
    # INITIAL STEP, PLUCK ALL CATEGORIES FROM THE LIST OF EXPENSES
    # extract actual report objects
    @actual_report_object = ExpenseReport.new
    @actual_report_type = ExpenseType.new

    # iterate through all categories and get all expenses that matches that category
    expense_report.expense_category.each do |q|
      actual_report_category = ExpenseCategory.new
      actual_report_category.name = q.name.to_s
      actual_report_category.expense_total = 0

      @expenses.each do |e|

        # if it matches the category of the expense, push to its corresponding array category and display
        if q.name.to_s == e.category.split('.')[0].to_s
          actual_report_category.expense_type.push(e)
          actual_report_category.expense_total += e[:amount]
        end
      end
      @actual_report_object.expense_category.push(actual_report_category)
    end

  end

end
