class StoreFake
  attr_reader :amount, :description, :created_at, :error, :have_form
  attr_writer :error, :created_at, :have_form

  def initialize(amount, description)
    @amount = amount
    @description = description
    @created_at = DateTime.new(2001,2,3)
    @have_form = true
  end

  def create
    self
  end

  def with_no_form
    self.have_form = false
  end

  def self.month_spendings(month, year)
    spend1 = new(100, "fake")
    spend2 = new(100, "fake")
    spend1.created_at = DateTime.new(year.to_i, month.to_i, 1)
    spend2.created_at = DateTime.new(year.to_i, month.to_i, 1)

    spends = [spend1, spend2]
    {spendings: spends}
  end

  def self.add_error
    spend = new(nil, nil)
    spend.error = "Se requieren todos los datos"
    spend
  end

  def self.current_month_spendings
    spend1 = new(100, "fake")
    spend2 = new(100, "fake")

    spends = [spend1, spend2]
    {spendings: spends}
  end

  def self.all_spendings
    spend1 = new(100, "fake")
    spend2 = new(100, "fake")
    spend1.created_at = DateTime.new(2001, 1, 3)
    [spend1, spend2]
  end
end
