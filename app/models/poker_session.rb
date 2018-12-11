class PokerSession < ApplicationRecord
  has_many :estimates
  has_many :users, through: :estimates

  def complete_session
    self.result = closest_story_number_to_average
    self.completed = true
    save
  end

  def closest_story_number_to_average
    memo = []
    story_points_with_differences.each do |array|
      if memo.empty?
        memo = array
      end

      if memo[1] > array[1]
        memo = array
      elsif memo[1] == array[1]
        memo = [memo, array].max_by {|arr| arr[0]}
      end
    end
    memo[0]
  end

  def story_points_with_differences
    scores.map(&:to_f).map do |score|
      [score, (average_estimate - score).abs]
    end
  end

  def average_estimate
    estimates.counted.pluck(:number).sum.to_f / estimates.counted.count
  end

  def already_voted_text
    have_has = estimates.one? ? 'has' : 'have'
    names = estimates.includes(:user).pluck(:name)
    "#{names.to_sentence} #{have_has} voted so far"
  end

  def user_estimates
    results = estimates.map(&:result_string)
    results.to_sentence
  end

  def complete_session_text
    "*#{story_name}*" + "\n" +  user_estimates + "\n" + "*The average vote was #{result_text}*"
  end

  def result_text
    if timebox?
      "#{strip_zeros(result)} #{'day'.pluralize(result)}"
    else
      strip_zeros(result)
    end
  end

  def timebox?
    type == 'PokerSession::Timebox'
  end
end
