class ToolUser < ActiveRecord::Base
  belongs_to :tool
  belongs_to :work_group, class_name: 'CodeValue'

  validates :tool, presence: true
  validate  :user_present

  def is_link?
    external_list && !external_list.empty?
  end

  def name_of_user
    if work_group
      work_group.print_name
    else
      organization_name
    end
  end

  private
  def user_present
    if external_list.nil? && work_group.nil? && organization_name.nil?
      errors.add(:organization_name, 'one of workgroup/external list/organization name must be present')
    end
  end
end