class PersonOrg < ActiveRecord::Base
  has_many :tool_persons

  validates :name, presence: true
  validate  :check_is_organization
  validate  :check_active
  validates :contact_phone, length: { maximum: 20 }
  validates :contact_email, length: { maximum: 80 }

  private
  def check_is_organization
    if self.is_organization.nil?
      errors.add(:is_organization, :blank)
    else
      errors.add(:is_organization, 'must be true or false') unless self.is_organization.in? [true, false]
    end
  end

  def check_active
    if self.active.nil?
      errors.add(:active, :blank)
    else
      errors.add(:active, 'must be true or false') unless self.active.in? [true, false]
    end
  end
end
