class Base

  def initialize(attributes)
    attributes.each do |key, value|
      var_name = "@#{key}"
      instance_variable_set(var_name, value)
    end
  end

  def method_missing(name)
    super unless instance_variable_get("@#{name}")
    instance_variable_get("@#{name}")
  end

  def respond_to_missing?(name, include_private = false)
    instance_variable_get("@#{name}") || super
  end

end