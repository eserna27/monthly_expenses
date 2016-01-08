require 'spec_helper'
require_relative '../app/application/spending_pages'
require_relative '../spec/store_fake'

describe "Index page when controller no send params" do
  it "should recive an current month object with some params" do
    items = SpendingPages.index_page({month: nil, year: nil}, StoreFake)
    expect(items[:spending].have_form).to eq true
    expect(items[:spendings].length).to eq 1
    expect(items[:month_total_spends]).to eq 200
    expect(items[:months].first[:text]).to eq "Enero 2001"
  end
end

describe "Index page when controller send params" do
  it "should recive month object with some params" do
    items = SpendingPages.index_page({month: 1, year: 2001}, StoreFake)
    expect(items[:spending].have_form).to eq false
    expect(items[:spendings][:spendings].first.created_at).to eq DateTime.new(2001, 1, 1)
    expect(items[:month_total_spends]).to eq 200
    expect(items[:months].first[:text]).to eq "Enero 2001"
  end
end
