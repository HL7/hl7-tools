class ToolSearch
  attr_accessor :area, :standard, :search_text

  def initialize(attrs={})
    attrs.each do |name, value|
      send("#{name}=", value)
    end
  end
end