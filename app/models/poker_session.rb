class PokerSession < ApplicationRecord
  has_many :estimates
  SPRINT_NUMBERS = [1, 2, 3, 5, 8, 13, 20, 40, 100]

  def complete!
  end

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
end
