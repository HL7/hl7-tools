class ToolUser < ActiveRecord::Base
  belongs_to :tool
  belongs_to :work_group, class_name: 'CodeValue'
end