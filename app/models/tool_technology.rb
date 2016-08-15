class ToolTechnology < ActiveRecord::Base
  belongs_to :tool

  validates :tool, presence: true
  validates :technology, code: { table: 'technology', presence: true }
  validates :tech_version, length: { maximum: 30 }

  def tech_code_value
    @tech_code_value ||= CodeValue.find_by(code_table: 'technology', code: technology)
  end
end
