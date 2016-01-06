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

  def self.months_with_spendings(store)
    all_spendings = store.all_spendings
    months = all_spendings.map { |spend|
      date = Date::MONTHNAMES[spend.created_at.month] + " " + spend.created_at.year.to_s
      respond = {
        text: date, month: spend.created_at.month, year: spend.created_at.year
      }
    }.uniq
  end

  def self.month_total_spends(spends)
    spends.inject(0) { |sum, spend| sum + spend.amount }
  end

  def self.month_spendings(attrs, store)
    store.month_spendings(attrs[:month].to_i, attrs[:year].to_i) 
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

  def self.month_spendings(month, year)
    dt = DateTime.new(year, month, 1)
    boy = dt.beginning_of_month
    eoy = dt.end_of_month
    Spending.where("created_at >= ? and created_at <= ?", boy, eoy).order("created_at DESC")
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
