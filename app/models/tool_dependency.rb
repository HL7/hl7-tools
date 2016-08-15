class ToolDependency < ActiveRecord::Base
  belongs_to :tool

  belongs_to :dependency, class_name: 'Tool'

  validates :tool, presence: true
  validates :dependency, presence: true
end
