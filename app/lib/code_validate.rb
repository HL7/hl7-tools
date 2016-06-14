# CANA Software and Services (c)2016 Licensed under the Eclipse EPL

module CodeValidate
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def validates_code_value(*attr_names)
      configuration = { allow_nil: false, table_name: nil }
      configuration.update(attr_names.extract_options!)

      validates_each(attr_names, configuration) do |record, attr_name, value|
        attr_value = record.send(attr_name.to_sym)
        if attr_value.nil?
          record.errors.add(attr_name,
                            I18n.t(:empty, scope: [:activerecord, :errors, :messages])) unless configuration[:allow_nil]
        elsif configuration[:table_name].nil?
          raise "CodeValue table name missing in validation of #{attr_name}"
        else
          unless CodeValue.table_code_list(configuration[:table_name]).include?('%-8.8s' % attr_value)
            record.errors.add(attr_name, " #{attr_value} is not a valid code in #{configuration[:table_name]}")
          end
        end
      end
    end
  end
end
