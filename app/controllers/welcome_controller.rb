class WelcomeController < ApplicationController
  def index
    @spending = Spend.new(SpendingStore)
    @spendings = Spend.current_month_spends(SpendingStore)
    @month_total_spends = Spend.month_total_spends(@spendings)
  end
end
