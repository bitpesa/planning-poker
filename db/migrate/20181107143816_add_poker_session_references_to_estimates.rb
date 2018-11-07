class AddPokerSessionReferencesToEstimates < ActiveRecord::Migration[5.2]
  def change
    add_reference :estimates, :poker_session, foreign_key: true
  end
end
