class ToolUser < ActiveRecord::Base
  belongs_to :tool
  belongs_to :work_group, class_name: 'CodeValue'

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
end