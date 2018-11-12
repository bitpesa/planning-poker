class User < ApplicationRecord
  has_many :estimates
  RECENT_VOTER_THRESHOLD = 1.hour.ago

  def self.recent_voters
    joins(:estimates).where('estimates.created_at > ?', RECENT_VOTER_THRESHOLD).uniq
  end

  def self.still_waiting_for(poker_session)
    remaining_voters = recent_voters - poker_session.users
    remaining_voters.pluck(:name).to_sentence
  end
end
