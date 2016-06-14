module LocalPresenterHelper
  def get_label_text(method, options)
    label_suffix_char = options.has_key?(:label_suffix) ? options[:label_suffix] : ":"

    if options.has_key?(:label)
      options[:label]
    else
      klass = get_base_object(options).class
      temp_label = I18n.t("label.#{klass}.#{method.to_s}",
                          default: klass.human_attribute_name(method.to_s).titleize)
      temp_label + label_suffix_char
    end
  end

  def get_base_object(options)
    options.has_key?(:object) ? options[:object] : self.record
  end

  private
  def is_money_field?(field)
    field =~ /_cents$/
  end
end