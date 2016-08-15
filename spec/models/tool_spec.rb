require 'rails_helper'

RSpec.describe Tool, type: :model do
  context 'creation' do
    subject { FactoryGirl.build(:tool) }
    it { should be_valid }
  end

  context 'validation' do
    subject { FactoryGirl.build(:tool) }

    it { should fail_with_null(:name) }

    it { should pass_with_null(:description) }
    it { should pass_with_null(:purpose) }
    it { should pass_with_null(:url) }
    it { should pass_with_null(:support_url) }
    it { should pass_with_null(:version) }
    it { should fail_with_null(:internal) }
    it { should pass_with_null(:functional_area) }
    it { should fail_with_null(:active) }
    it { should pass_with_null(:license) }
    it { should pass_with_null(:aka) }
    it { should pass_with_null(:product) }
    it { should pass_with_null(:rollout_date) }
    it { should pass_with_null(:last_update_date) }

    it 'should validate functional_area codes' do
      expect(FactoryGirl.build(:tool, functional_area: ['impl'])).to be_valid
      expect(FactoryGirl.build(:tool, functional_area: ['std-dev', 'impl'])).to be_valid

      expect(FactoryGirl.build(:tool, functional_area: ['std-dev', 'impl', 'fred'])).not_to be_valid

      expect(FactoryGirl.build(:tool, functional_area: ['fred'])).not_to be_valid
      object = FactoryGirl.build(:tool, functional_area: ['fred'])
      object.valid?
      expect(object.errors[:functional_area].count).to be > 0
    end

    it 'should validate license code' do
      expect(FactoryGirl.build(:tool, license: 'epl')).to be_valid

      expect(FactoryGirl.build(:tool, license: 'fred')).not_to be_valid
      object = FactoryGirl.build(:tool, license: 'fred')
      object.valid?
      expect(object.errors[:license].count).to be > 0
    end

    it 'should validate product codes' do
      expect(FactoryGirl.build(:tool, product: ['V2'])).to be_valid
      expect(FactoryGirl.build(:tool, product: ['V2', 'V3'])).to be_valid

      expect(FactoryGirl.build(:tool, product: ['V2', 'V3', 'fred'])).not_to be_valid

      expect(FactoryGirl.build(:tool, product: ['fred'])).not_to be_valid
      object = FactoryGirl.build(:tool, product: ['fred'])
      object.valid?
      expect(object.errors[:product].count).to be > 0
    end

    it 'should strip empty functional_area values'
    it 'should strip empty product values'
  end
end
