class ToolAssessment < ActiveRecord::Base
  belongs_to :tool

  RISK_LEVEL = ['failing continuously', 'collapse imminent', 'near collapse', 'many problems',
                'lacks support', 'barely supported', 'supported', 'well supported',
                'minor', 'insignificant', 'no risk']
  QUALITY_LEVEL = ['code cannot be fixed', 'massive re-engineering', 're-engineer', 'rewrite many components',
                   'long-standing problems', 'many issues', 'some issues', 'cosmetic issues',
                   'no known issues', 'no issues with automatic tests', 'flawless']
  SUSTAINABILITY_LEVEL = ['extinct technology', 'antiquated technology', 'no-longer supported', 'must be replaced',
                          'obscure technology', 'unusual technology', 'old versions', 'common platforms',
                          'standard platforms', 'up to date', 'fully modern']
  USABILITY_LEVEL = ['no-one can run', 'run by single person', 'highly select group',
                     'requires skills not usually found',
                     'extensive training', 'requires training', 'must read manual', 'easy to run',
                     'run without instructions', 'non-technical users', 'understood by children']

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
