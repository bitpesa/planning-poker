class Estimate < ApplicationRecord
  belongs_to :poker_session
  belongs_to :user

  validates_presence_of :number

  validates :poker_session_id,
    uniqueness: {
    scope: :user_id,
    message: 'user has already given an estimate for this session!'
  }

  scope :counted, ->{ where(skip_vote: false) }

  def result_string
    if skip_vote
      "#{user.name} skipped voting"
    else
      "#{user.name} voted #{number_text}"
    end
  end

  def number_text
    if poker_session.timebox?
      "#{number} days"
    else
      number
    end
  end
end
