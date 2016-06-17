class ToolSearch
  attr_accessor :search_text
  attr_reader   :area, :product

  def initialize(attrs={})
    attrs.each do |name, value|
      send("#{name}=", value)
    end
  end

  def product=(value)
    @product = value.delete_if { |item| item.nil? || item.size == 0}
  end

  def area=(value)
    @area = value.delete_if { |item| item.nil? || item.size == 0}
  end

  def present?
    !search_text.empty? || product.count > 0 || area.count > 0
  end
end