class CreateSpendings < ActiveRecord::Migration
  def change
    create_table :spendings do |t|
      t.float :amount

      t.timestamps null: false
    end
  end
end
