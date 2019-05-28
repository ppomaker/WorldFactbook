require 'rexml/document'
require_relative '../../lib/continent/continent'
require_relative '../../lib/country/country'

class WorldFactbook

  include REXML

  attr_reader :continents, :countries

  def initialize(source_file_name)
    doc = Document.new File.new(source_file_name)
  rescue StandardError => e
    puts 'An error occured:', e
    raise e
  else
    initialize_continents(doc)
    initialize_countries(doc)
  end

  def initialize_continents(doc)
    @continents = []
    doc.elements.each(Continent.xpath) do |element|
      @continents << Continent.new(element.attributes)
    end
  end

  def initialize_countries(doc)
    @countries = []
    doc.elements.each(Country.xpath) do |element|
      @countries << Country.new(element.attributes)
    end
  end

  def max_population_country
    @countries
      .filter { |c| c.respond_to?(:population) }
      .max { |c| c.population.to_i }
  end

  def max_inflation_countries(n)
    @countries
      .filter { |c| c.respond_to?(:inflation) }
      .sort { |c1, c2| -(c1.inflation.to_f <=> c2.inflation.to_f) }
      .take n
  end

  def continents_with_countries
    @continents
      .filter { |c| c.respond_to?(:name) }
      .map do |cont|
        cont.countries = @countries.filter do |c|
          c.respond_to?(:continent) && c.continent == cont.name
        end
        cont
      end
      .sort_by(&:name)
  end

  private :initialize_continents, :initialize_countries

end