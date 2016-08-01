class ToolPerson < ActiveRecord::Base
  belongs_to :tool
  belongs_to :person_org

  def role_code_value
    CodeValue.find_by(code_table: 'role', code: self.role)
  end
end

