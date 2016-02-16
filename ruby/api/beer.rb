require 'yaml'

class Beer
  def self::all
    beers = YAML.load(File.read('./beers.yaml')) || []
    beers.map { |beer| Hashie::Mash.new(beer) }
  end

  def self::create(params)
    beers = YAML.load(File.read('./beers.yaml')) || []
    beers << params.merge('id' => next_id(beers))
    file = File.write('./beers.yaml', YAML.dump(beers))
  end

  private

  def self::next_id(beers)
    if beers.any?
      beers.sort { |x, y| y['id'] <=> y['id'] }.last['id'] + 1
    else
      1
    end
  end
end
