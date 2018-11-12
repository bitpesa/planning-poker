class PokerSession < ApplicationRecord
  has_many :estimates
  has_many :users, through: :estimates
  STORY_POINTS = [1, 2, 3, 5, 8, 13, 20, 40, 100]

  def complete_session
    self.result = closest_story_number_to_average
    self.completed = true
    save
  end

  def closest_story_number_to_average
    story_points_with_differences.inject([]) do |memo, array|
      if memo.empty?
        memo = array
        break
      end

      if memo[1] > array[1]
        memo = array
      elsif memo[1] == array[1]
        memo = [memo, array].max_by {|arr| arr[0]}
      end
      memo
    end
  end

  def story_points_with_differences
    STORY_POINTS.map do |story_point|
      [story_point, (average_estimate - story_point).abs]
    end
  end

  def average_estimate
    estimates.pluck(:number).sum / estimates.count
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
end
