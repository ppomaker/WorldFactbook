class Country

  def self.xpath
    'cia/country'
  end

  def initialize(attributes)
    attributes.each do |key, value|
      var_name = "@#{key}"
      instance_variable_set(var_name, value)
      Country.define_method(key, -> { instance_variable_get(var_name) })
    end
  end
end