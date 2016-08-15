class ToolAssessment < ActiveRecord::Base
  belongs_to :tool

  validates :tool, presence: true
  validates :assessment_date, presence: true
  validate  :check_required
  validates :risk, numericality: { only_integer: true, greater_than_or_equal_to: 0,
                                   less_than_or_equal_to: 100}
  validates :quality, numericality: { only_integer: true, greater_than_or_equal_to: 0,
                                      less_than_or_equal_to: 100}
  validates :sustainability, numericality: { only_integer: true, greater_than_or_equal_to: 0,
                                             less_than_or_equal_to: 100}
  validates :usability, numericality: { only_integer: true, greater_than_or_equal_to: 0,
                                        less_than_or_equal_to: 100}

  private
  def check_required
    if self.required.nil?
      errors.add(:required, :blank)
    else
      errors.add(:required, 'must be true or false') unless self.required.in? [true, false]
    end
  end
end
