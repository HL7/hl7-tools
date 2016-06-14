class Tool < ActiveRecord::Base
  has_many :tool_assessments
  has_many :tool_dependencies
  has_many :tool_technologies
  has_many :tool_persons
  has_many :tool_notes

  def functional_tags
    tags = []
    if functional_area
      functional_area.each do |fn_area|
        code = CodeValue.find_by(code_table: 'func-area', code: fn_area)
        tags << code.print_name if code
      end
    end
    tags
  end

  def product_tags
    tags = []
    if standard
      standard.each do |fn_area|
        code = CodeValue.find_by(code_table: 'standard', code: fn_area)
        tags << code.print_name if code
      end
    end
    tags
  end
end
