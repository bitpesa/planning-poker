class AddSkipVoteToEstimate < ActiveRecord::Migration[5.2]
  def change
    add_column :estimates, :skip_vote, :boolean, default: false
  end
end
