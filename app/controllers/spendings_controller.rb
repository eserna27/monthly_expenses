class SpendingsController < ApplicationController

  def index
    @spending = Spend.new(SpendingStore)
    if params[:month] == nil || params[:year] == nil
      @spendings = Spend.current_month_spends(SpendingStore)
    else
      @spendings = Spend.month_spendings({month: params[:month], year: params[:year]}, SpendingStore)
    end
    @month_total_spends = Spend.month_total_spends(@spendings)
    @months = Spend.months_with_spendings(SpendingStore)
  end

  def create
    spend = Spend.new_with_amount(params[:spending][:amount], params[:spending][:description], SpendingStore)
    if defined?(spend.error)
      flash[:alert] = spend.error
    end
    redirect_to spendings_path
  end
end
