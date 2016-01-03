require 'active_model'

module Spend
  def self.new(store)
    store.new(nil, nil)
  end

  def self.new_with_amount(amount, description, store)
    if amount != "" && description != ""
      spend = store.new(amount, description)
      spend.create
    else
      store.add_error
    end
  end

  def self.all_spends(store)
    store.all_spendings
  end

  def self.current_month_spends(store)
    store.current_month_spendings
  end

  def self.month_total_spends(spends)
    spends.inject(0) { |sum, spend| sum + spend.amount }
  end
end

class SpendingStore
  attr_reader :amount, :description, :error
  attr_writer :error

  def initialize(amount, description)
    @amount = amount
    @description = description
    @error = nil
  end

  def self.add_error
    spend = new(nil, nil)
    spend.error = "Se requieren todos los datos"
    spend
  end

  def persisted?
    false
  end

  def create
    Spending.create(amount: amount, description: description)
  end

  def self.all_spendings
    Spending.all
  end

  def self.current_month_spendings
    dt = Date.today.to_datetime
    boy = dt.beginning_of_month
    eoy = dt.end_of_month
    Spending.where("created_at >= ? and created_at <= ?", boy, eoy).order("created_at DESC")
  end
end
