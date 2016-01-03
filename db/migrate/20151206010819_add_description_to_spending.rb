class AddDescriptionToSpending < ActiveRecord::Migration
  def change
    add_column :spendings, :description, :text
  end
end
