class ToolPerson < ActiveRecord::Base
  before_validation :remove_array_empty

  ACTIVE_LEVEL = ['not active', 'emergencies only', 'very limited', 'limited', 'when needed',
                  'occasional', 'up to date', 'regular', 'current', 'frequent', 'full-time']

  belongs_to :tool
  belongs_to :person_org

  validates :tool, presence: true
  validates :person_org, presence: true
  validates :role, code: {table: 'role', presence: true, array: true}
  validates :activity, numericality: { only_integer: true, greater_than_or_equal_to: 0,
                                       less_than_or_equal_to: 10}
  validates :updated_at, presence: true

  def role_list
    tags = []
    if role
      role.each do |role_code|
        code = CodeValue.find_by(code_table: 'role', code: role_code)
        tags << code.print_name if code
      end
    end
    tags
  end

  private
  def remove_array_empty
    unless role.nil?
      role.reject! { |l| l.empty? }
    end
  end
end

