class SpendingsController < ApplicationController

  def index
    @page_items = SpendingPages.index_page(params, SpendingStore)
  end

  def create
    spend = Spend.new_with_amount(params[:spending][:amount], params[:spending][:description], SpendingStore)
    if defined?(spend.error)
      flash[:alert] = spend.error
    end
    redirect_to spendings_path
  end
end
