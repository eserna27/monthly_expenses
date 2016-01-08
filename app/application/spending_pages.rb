require 'active_model'

module SpendingPages
  def self.index_page(params, store)
    if params[:month]
      SpendingsFunctions.month_index(params, store)
    else
      SpendingsFunctions.current_month_index(store)
    end
  end
end

module SpendingsFunctions
  def self.current_month_index(store)
    spending = Spend.new(store)
    spendings = Spend.current_month_spends(store)
    month_total_spends = Spend.month_total_spends(spendings[:spendings])
    months = Spend.months_with_spendings(store)
    {spending: spending, spendings: spendings, month_total_spends: month_total_spends, months: months}
  end

  def self.month_index(params, store)
    spending = Spend.new(store)
    spending.with_no_form
    spendings = Spend.month_spendings(params, store)
    month_total_spends = Spend.month_total_spends(spendings[:spendings])
    months = Spend.months_with_spendings(store)
    {spending: spending, spendings: spendings, month_total_spends: month_total_spends, months: months}
  end
end
