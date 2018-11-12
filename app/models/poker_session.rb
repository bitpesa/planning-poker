class PokerSession < ApplicationRecord
  has_many :estimates
  SPRINT_NUMBERS = [1, 2, 3, 5, 8, 13, 20, 40, 100]

  def complete_session
    average = estimates.pluck(:number).sum / estimates.count

    differences = SPRINT_NUMBERS.map do |sn|
      [sn, (average - sn).abs]
    end

    closest_sprint_number = differences.min_by { |arr| arr[1] }[0]
    self.result = closest_sprint_number
    self.completed = true
    save
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
