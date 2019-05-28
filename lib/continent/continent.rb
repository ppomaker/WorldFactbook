require_relative '../base/base'

class Continent < Base

  attr_accessor :countries

  def self.xpath
    'cia/continent'
  end
end