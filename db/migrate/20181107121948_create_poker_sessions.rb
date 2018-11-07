class CreatePokerSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :poker_sessions do |t|
      t.boolean :completed
      t.integer :result

      t.timestamps
    end
  end
end
