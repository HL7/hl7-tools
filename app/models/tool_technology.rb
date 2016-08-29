class ToolTechnology < ActiveRecord::Base
  belongs_to :tool

  validates :tool, presence: true
  validates :technology, code: { table: 'technology', presence: true }
  validates :tech_version, length: { maximum: 30 }

  def technology_name
    @tech_name_value ||= get_tech_name
  end

  private
  def get_tech_name
    code = CodeValue.find_by(code_table: 'technology', code: technology)
    code.nil? ? "Unknown technology: #{technology}" : code.print_name
  end
end
