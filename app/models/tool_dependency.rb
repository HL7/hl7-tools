class ToolDependency < ActiveRecord::Base
  belongs_to :tool

  belongs_to :dependency, class_name: 'Tool'
end
