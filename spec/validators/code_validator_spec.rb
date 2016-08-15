require 'rails_helper'

def code_validator_class(options)
  Class.new(ValidationTester) do
    attr_accessor :role

    validates :role, code: options
  end
end

describe CodeValidator do
  let(:role_table) { 'role' }

  describe '#validates_each(record, attribute, value)' do
    let(:options)    { {table: role_table} }
    let(:test_model) { code_validator_class(options).new }

    it 'fails when there is no text' do
      test_model.role = ''
      test_model.valid?
      expect(test_model.errors[:role].size).to eq 1
    end

    it 'passes when null value and no presence' do
      test_model.role = nil
      expect(test_model).to be_valid
    end

    it 'passes when value is in the table' do
      test_model.role = 'dev'
      expect(test_model).to be_valid
    end

    it 'fails when value is not in the table' do
      test_model.role = 'dog'
      expect(test_model).not_to be_valid
    end

    it 'returns the blank error message when empty' do
      test_model.role = ''
      test_model.valid?
      expect(test_model.errors[:role]).to eq [I18n.t('errors.messages.blank')]
    end

    it 'returns the default error message when wrong value' do
      test_model.role = 'dog'
      test_model.valid?
      expect(test_model.errors[:role]).to eq [I18n.t('errors.messages.code_invalid',
                                                     code: 'dog', value_set: role_table)]
    end

    context 'options' do
      context 'contains a custom error message' do
        let(:custom_message) { 'this is a custom message' }
        let(:new_options)    { {table: role_table, message: custom_message} }
        let(:test_model)     { code_validator_class(new_options).new }

        it 'uses the custom message' do
          test_model.role = 'dog'
          test_model.valid?
          expect(test_model.errors[:role]).to eq [custom_message]
        end
      end

      context 'missing the table definition' do
        let(:options)    { {} }
        let(:test_model) { code_validator_class(options).new }

        it 'fails when the table is not specified' do
          test_model.role = 'dev'
          test_model.valid?
          expect(test_model.errors[:role]).to eq [I18n.t('errors.messages.code_table_missing')]
        end
      end

      context 'contains the presence' do
        let(:new_options)    { {table: role_table, presence: true} }
        let(:test_model)     { code_validator_class(new_options).new }

        it 'passes when contains valid value' do
          test_model.role = 'dev'
          expect(test_model).to be_valid
        end

        it 'fails when contains invalid value' do
          test_model.role = 'dog'
          test_model.valid?
          expect(test_model.errors[:role]).to eq [I18n.t('errors.messages.code_invalid',
                                                         code: 'dog', value_set: role_table)]
        end

        it 'fails when contains null value' do
          test_model.role = nil
          test_model.valid?
          expect(test_model.errors[:role]).to eq [I18n.t('errors.messages.blank')]
        end
      end

      context 'allows array codes' do
        let(:new_options)    { {table: role_table, array: true} }
        let(:test_model)     { code_validator_class(new_options).new }

        it 'passes when contains valid value' do
          test_model.role = ['dev']
          expect(test_model).to be_valid
        end

        it 'passes when contains multiple valid values' do
          test_model.role = ['dev', 'maint']
          expect(test_model).to be_valid
        end

        it 'fails when contains any bad values' do
          test_model.role = ['dev', 'maint', 'dog']
          expect(test_model).not_to be_valid
        end
      end
    end
  end
end