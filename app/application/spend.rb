require 'active_model'

module Spend
  @months_name = ["", "Enero", "Febrero", "Marzo", "Abril", "Mayo",
     "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"]

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
      date = @months_name[spend.created_at.month] + " " + spend.created_at.year.to_s
      respond = {
        text: date, month: spend.created_at.month, year: spend.created_at.year
      }
    }.uniq
    delete_current_month(months)
  end

  def self.delete_current_month(months)
    months.delete(months.last)
    months
  end

  def self.month_total_spends(spends)
    spends.inject(0) { |sum, spend| sum + spend.amount }
  end

  def self.month_spendings(attrs, store)
    store.month_spendings(attrs[:month].to_i, attrs[:year].to_i)
  end
end
