class AddTypeToPokerSession < ActiveRecord::Migration[5.2]
  def change
    add_column :poker_sessions, :type, :string
  end
end
