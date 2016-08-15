class ToolNote < ActiveRecord::Base
  belongs_to :tool

  validates :tool, presence: true
  validates :note, presence: true
  validates :note_date, presence: true
  validates :author, length: { maximum: 60 }
end
