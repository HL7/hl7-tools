# CANA Software and Services (c)2016 Licensed under the Eclipse EPL

class CodeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if !options.key?(:table)
      record.errors.add(attribute, :code_table_missing)
    elsif value.nil? && options.key?(:presence) && options[:presence]
      record.errors.add(attribute, :blank)
    elsif value && options[:array]
      value.each do |single_val|
        if missing?(options[:table], single_val)
          record.errors.add(attribute, error_message, code: single_val, value_set: options[:table])
        end
      end
    elsif value && value.length == 0
      record.errors.add(attribute, :blank)
    elsif value && options.key?(:table) && missing?(options[:table], value)
      record.errors.add(attribute, error_message, code: value, value_set: options[:table])
    end
  end

  private
  def missing?(table, value)
    CodeValue.where(code_table: table, code: value).count < 1
  end

  def error_message
    options.fetch(:message, :code_invalid)
  end
end