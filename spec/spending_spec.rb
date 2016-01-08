require 'spec_helper'
require_relative '../app/application/spend'
require_relative '../spec/store_fake'

describe 'New spending' do
  it "should have an amount" do
    spend = Spend.new(StoreFake)
    expect(spend.amount).to eq nil
    expect(spend.description).to eq nil
    expect(spend.have_form).to eq true
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
    spends[:spendings].map { |spend| expect(spend.created_at).to eq Date.new(2001,2,3)}
  end

  it "should recive a total of month spends" do
    spends = Spend.current_month_spends(StoreFake)
    total_spend = Spend.month_total_spends(spends[:spendings])
    expect(total_spend).to eq 200
  end
end

describe "Months spendings" do
  it "should recive an array for all the months have spendings" do
    months = Spend.months_with_spendings(StoreFake)
    expect(months.length).to eq 1
    months.map { |month|
      expect(month[:text]).to eq "Enero 2001"
      expect(month[:month]).to eq 1
      expect(month[:year]).to eq 2001
    }
  end
end

describe "Month filter" do
  it "should recive an array of all the spendings of selected month" do
    month_spendings = Spend.month_spendings({month: "1", year: "2015"}, StoreFake)
    expect(month_spendings[:spendings].first.created_at).to eq DateTime.new(2015, 1, 1)
  end
end
