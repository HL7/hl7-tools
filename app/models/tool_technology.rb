class ToolTechnology < ActiveRecord::Base
  belongs_to :tool

  def tech_code_value
    @tech_code_value ||= CodeValue.find_by(code_table: 'technology', code: technology)
  end
end
