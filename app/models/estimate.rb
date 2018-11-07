class Estimate < ApplicationRecord
  belongs_to :poker_session
  belongs_to :user

  validates :poker_session_id,
    uniqueness: {
      scope: :user_id,
      message: 'user has already given an estimate for this session!'
    }
end
