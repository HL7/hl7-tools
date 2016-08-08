module ApplicationHelper
  def is_admin?
    ENV['HL7_TOOL_EDITING'] == 'TRUE'
  end
end
