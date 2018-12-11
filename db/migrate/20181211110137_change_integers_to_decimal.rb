class ChangeIntegersToDecimal < ActiveRecord::Migration[5.2]
  def change
    change_column :estimates, :number, :decimal, precision: 8, scale: 2
    change_column :poker_sessions, :result, :decimal, precision: 8, scale: 2
  end
end
