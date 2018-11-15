class AddStoryNameToPokerSession < ActiveRecord::Migration[5.2]
  def change
    add_column :poker_sessions, :story_name, :string
  end
end
