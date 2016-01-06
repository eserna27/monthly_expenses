require 'spec_helper'
require_relative '../app/application/spend'

describe 'New spending' do
  it "should have an amount" do
    spend = Spend.new(StoreFake)
    expect(spend.amount).to eq nil
    expect(spend.description).to eq nil
  end
end

describe "Create spending" do
  it "should recive an amount and return ok" do
    spend = Spend.new_with_amount(100, "Oxxo", StoreFake)
    expect(spend.amount).to eq 100
    expect(spend.description).to eq "Oxxo"
    expect(spend.error).to eq nil
  end

  it "should recive error if does not have values" do
    spend = Spend.new_with_amount("", "", StoreFake)
    expect(spend.error).to eq "Se requieren todos los datos"
  end
end

describe "Show spendings" do
  it "should recive an array of spendings" do
    spend = Spend.new_with_amount(100, "Oxxo", StoreFake)
    spends = Spend.all_spends(StoreFake)
    spends.map { |spend|  expect(spend.amount).to eq 100}
  end
end

describe "Month spendings" do
  it "should recive an array with current month spendings" do
    spends = Spend.current_month_spends(StoreFake)
    spends.map { |spend| expect(spend.created_at).to eq Date.new(2001,2,3)}
  end

  it "should recive a total of month spends" do
    spends = Spend.current_month_spends(StoreFake)
    total_spend = Spend.month_total_spends(spends)
    expect(total_spend).to eq 200
  end
end

describe "Months spendings" do
  it "should recive an array for all the months have spendings" do
    months = Spend.months_with_spendings(StoreFake)
    expect(months.length).to eq 1
    months.map { |month|
      expect(month[:text]).to eq "February 2001"
      expect(month[:month]).to eq 2
      expect(month[:year]).to eq 2001
    }
  end
end

describe "Month filter" do
  it "should recive an array of all the spendings of selected month" do
    month_spendings = Spend.month_spendings({month: "1", year: "2015"}, StoreFake)
    expect(month_spendings).to eq DateTime.new(2015, 1, 1)
  end
end

class StoreFake
  attr_reader :amount, :description, :created_at, :error
  attr_writer :error

  def initialize(amount, description)
    @amount = amount
    @description = description
    @created_at = DateTime.new(2001,2,3)
  end

  def create
    self
  end

  def self.month_spendings(month, year)
    DateTime.new(year.to_i, month.to_i, 1)
  end

  def self.add_error
    spend = new(nil, nil)
    spend.error = "Se requieren todos los datos"
    spend
  end

  def self.current_month_spendings
    spend1 = new(100, "fake")
    spend2 = new(100, "fake")
    [spend1, spend2]
  end

  def self.all_spendings
    spend = new(100, "fake")
    [spend]
  end
end
