class Continent

  attr_accessor :countries

  def self.xpath
    'cia/continent'
  end

  def initialize(attributes)
    attributes.each do |key, value|
      var_name = "@#{key}"
      instance_variable_set(var_name, value)
      Continent.define_method(key, -> { instance_variable_get(var_name) })
    end
  end
end