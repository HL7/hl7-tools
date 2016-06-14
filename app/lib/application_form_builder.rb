class ApplicationFormBuilder < ActionView::Helpers::FormBuilder
  delegate :content_tag, :tag, :concat, :link_to, to: :@template

  include LocalPresenterHelper

  alias_method :old_text_field, :text_field
  alias_method :old_number_field, :number_field
  alias_method :old_check_box, :check_box
  alias_method :old_collection_check_boxes, :collection_check_boxes
  alias_method :old_collection_select, :collection_select

  %w[ number_field text_field text_area check_box collection_select file_field
      collection_check_boxes collection_radio_buttons date_field ].each do |method_name|
    define_method(method_name) do |the_method_name, *args, &block|
      content_tag :div, class: 'field' do
        field_label(the_method_name, *args) +
            content_tag(:div, class: 'field-entry') do
              super(the_method_name, *args, &block)
            end
      end
    end
  end

  def wrap(name, *args, &block)
    content_tag :div, class: 'field' do
      concat(field_label(name, *args))
      yield(self)
    end
  end

  def choice_block(name, *args, &block)
    content_tag :div, class: 'choice' do
      field_label(name, *args) +
          content_tag(:div, class: 'options') do
        yield(self)
      end
    end
  end

  def buttons(*args)
    options = args.extract_options!
    if object.new_record?
      button_text = 'Create'
    else
      button_text = 'Save'
    end
    content_tag :div, class: 'button-area' do
      concat(submit(button_text, class: 'form-button'))
      concat(link_to('Cancel', options[:cancel], class: 'fancy-push-button')) if options.has_key?(:cancel)
    end
  end

  def record
    @object
  end

  private
  def field_label(name, *args)
    options = args.extract_options!
    label_classes = 'main-label'
    required = object.class.validators_on(name).any? { |v| v.kind_of? ActiveModel::Validations::PresenceValidator }
    label_classes = label_classes.concat(' required') if required
    label(name, get_label_text(name, options), class: label_classes)
  end
end