
class SpendingStore
  attr_reader :amount, :description, :error, :have_form
  attr_writer :error, :have_form

  @months_name = ["", "Enero", "Febrero", "Marzo", "Abril", "Mayo",
     "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"]

  def initialize(amount, description)
    @amount = amount
    @description = description
    @error = nil
    @have_form = true
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

  def with_no_form
    self.have_form = false
  end

  def self.month_spendings(month, year)
    dt = DateTime.new(year, month, 1)
    boy = dt.beginning_of_month
    eoy = dt.end_of_month
    spendings = Spending.where("created_at >= ? and created_at <= ?", boy, eoy).order("created_at DESC")
    text = @months_name[dt.month] + " " + dt.year.to_s
    {spendings: spendings, text: text}
  end

  def self.all_spendings
    Spending.all.order("created_at ASC")
  end

  def self.current_month_spendings
    dt = Date.today.to_datetime
    boy = dt.beginning_of_month
    eoy = dt.end_of_month
    spendings = Spending.where("created_at >= ? and created_at <= ?", boy, eoy).order("created_at DESC")
    text = @months_name[dt.month] + " " + dt.year.to_s
    {spendings: spendings, text: text}
  end
end
