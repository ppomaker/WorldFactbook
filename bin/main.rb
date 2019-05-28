require_relative '../lib/world_factbook/world'


DEFAULT_SOURCE_FILE_NAME = '../share/cia-1996.xml'.freeze


if $PROGRAM_NAME == __FILE__

  default_handler = Proc.new do|filename|
    puts "Parsing file: #{filename}"
    w = WorldFactbook.new(filename)

    puts 'The country with the largest population:'
    puts "\t#{w.max_population_country.name}"

    puts 'The country with the highest rate of inflation:'
    w.max_inflation_countries(5).each do |c|
      puts "\tName: #{c.name}, Inflation: #{c.inflation}"
    end

    puts 'Continents with countries:'
    w.continents_with_countries.each do |cont|
      puts "#{cont.name}:"
      cont.countries.each { |c| puts "\t#{c.name}" }
    end
  end

  default_handler.call(DEFAULT_SOURCE_FILE_NAME) if ARGV.empty?

  ARGV.each(&default_handler)
end


