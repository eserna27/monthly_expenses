class SpendingsController < ApplicationController
  def create
    spend = Spend.new_with_amount(params[:spending][:amount], params[:spending][:description], SpendingStore)
    if defined?(spend.error)
      flash[:alert] = spend.error
    end
    redirect_to root_path
  end
end
