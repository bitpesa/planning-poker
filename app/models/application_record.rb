class ApplicationRecord < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  self.abstract_class = true

  def strip_zeros(number)
    number_with_precision(number, precision: 2, strip_insignificant_zeros: true)
  end
end
