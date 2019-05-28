require 'test/unit'
require 'rexml/document'
require_relative '../lib/world_factbook/world_factbook'

class TestWorldFactbook < Test::Unit::TestCase

  def test_handling_file_existance
    assert_raise(ArgumentError) do
      w = WorldFactbook.new('not_exist.xml')
    end

    assert_raise(REXML::ParseException) do
      w = WorldFactbook.new('parse_exception.xml')
    end
  end

  def test_initialize
    w = WorldFactbook.new('test_data.xml')
    assert_equal(w.continents.first.respond_to?(:id), true)
    assert_equal(w.continents.first.respond_to?(:name), true)
    assert_equal(w.continents.first.respond_to?(:other), false)
    assert_equal(w.continents.first.id, 'europe')
    assert_equal(w.continents.first.name, 'Europe')
    assert_equal(w.continents.length, 6)

    assert_equal(w.countries.first.respond_to?(:id), true)
    assert_equal(w.countries.first.respond_to?(:continent), true)
    assert_equal(w.countries.first.respond_to?(:name), true)
    assert_equal(w.countries.first.respond_to?(:datacode), true)
    assert_equal(w.countries.first.respond_to?(:total_area), true)
    assert_equal(w.countries.first.respond_to?(:population), true)
    assert_equal(w.countries.first.respond_to?(:total_area), true)
    assert_equal(w.countries.first.respond_to?(:population), true)
    assert_equal(w.countries.first.respond_to?(:population_growth), true)
    assert_equal(w.countries.first.respond_to?(:infant_mortality), true)
    assert_equal(w.countries.first.respond_to?(:gdp_agri), true)
    assert_equal(w.countries.first.respond_to?(:inflation), true)
    assert_equal(w.countries.first.respond_to?(:gdp_ind), true)
    assert_equal(w.countries.first.respond_to?(:gdp_serv), true)
    assert_equal(w.countries.first.respond_to?(:gdp_total), true)
    assert_equal(w.countries.first.respond_to?(:indep_date), true)
    assert_equal(w.countries.first.respond_to?(:government), true)
    assert_equal(w.countries.first.respond_to?(:capital), true)
    assert_equal(w.countries.first.respond_to?(:custom), false)
    assert_equal(w.countries.first.id, 'cid-cia-Belgium')
    assert_equal(w.countries.first.continent, 'Europe')
    assert_equal(w.countries.first.name, 'Belgium')
    assert_equal(w.countries.first.datacode, 'BE')
    assert_equal(w.countries.first.total_area, '30510')
    assert_equal(w.countries.first.population, '10170241')
    assert_equal(w.countries.first.population_growth, '0.33')
    assert_equal(w.countries.first.infant_mortality, '6.4')
    assert_equal(w.countries.first.gdp_agri, '2')
    assert_equal(w.countries.first.inflation, '1.6')
    assert_equal(w.countries.first.gdp_ind, '28')
    assert_equal(w.countries.first.gdp_serv, '70')
    assert_equal(w.countries.first.gdp_total, '197000')
    assert_equal(w.countries.first.indep_date, '04 10 1830')
    assert_equal(w.countries.first.government, 'constitutional monarchy')
    assert_equal(w.countries.first.capital, 'Brussels')
    assert_equal(w.countries.length, 11)
  end

  def test_max_population_country
    w = WorldFactbook.new('test_data.xml')
    assert_equal(w.max_population_country.name, 'Belarus')
  end

  def test_max_inflation_countries
    w = WorldFactbook.new('test_data.xml')
    assert_equal(w.max_inflation_countries(3).map(&:name),
                 %w[Belarus Bulgaria Albania])
  end

  def test_continents_with_countries
    w = WorldFactbook.new('test_data.xml')
    assert_equal(w.continents_with_countries.length, 6)
    assert_equal(w.continents_with_countries.map(&:name),
                 ['Africa', 'Asia', 'Australia/Oceania', 'Europe',
                  'North America', 'South America'])
    assert_equal(w.continents_with_countries[3].countries.map(&:name),
                 ['Belgium', 'Albania', 'Andorra', 'Austria', 'Belarus',
                  'Bosnia and Herzegovina', 'Bulgaria'])
  end

end