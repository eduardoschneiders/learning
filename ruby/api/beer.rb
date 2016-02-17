require 'yaml'

class Beer
  attr_accessor :name, :id

  def initialize(attrs)
    attrs.each { |attr| self.instance_variable_set("@#{attr[0]}", attr[1]) }
  end

  def to_json(attrs)
    properties.to_json
  end

  def save
    beer = properties
    begin
      beers = load_beers

      beers.delete_if { |beer| beer['id'] ==  self.id}
      beers << beer

      save_beers!(beers)
      true
    rescue
      false
    end
  end

  def update_attributes(attrs)
    attrs.each { |attr| self.instance_variable_set("@#{attr[0]}", attr[1]) }
    save
  end

  def self::find(id)
    beer = load_beers.detect do |beer|
      beer['id'] == id.to_i
    end

    Beer.new(beer) || []
  end

  def self::all
    beers = load_beers
    beers.map { |beer| Hashie::Mash.new(beer) }
  end

  def self::create(params)
    beers = load_beers
    beer = params.merge('id' => next_id(beers))
    beers << beer
    save_beers!(beers)
    beer
  end

  private

  def self::next_id(beers)
    if beers.any?
      beers.sort { |x, y| y['id'] <=> y['id'] }.last['id'] + 1
    else
      1
    end
  end

  def properties
    properties = {}
    self.instance_variables.each do |propertie|
      properties[propertie.to_s.delete('@')] = self.instance_variable_get(propertie)
    end

    properties
  end

  def self::load_beers
    YAML.load(File.read('./beers.yaml')) || []
  end

  def load_beers
    self.class.load_beers
  end

  def self::save_beers!(beers)
    File.write('./beers.yaml', YAML.dump(beers))
  end

  def save_beers!(beers)
    self.class.save_beers!(beers)
  end
end
