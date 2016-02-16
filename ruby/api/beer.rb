require 'yaml'

class Beer
  attr_accessor :name, :id

  def initialize(attrs)
    attrs.each { |attr| self.instance_variable_set("@#{attr[0]}", attr[1]) }
  end

  def to_json
    properties
  end

  def save
    beer = properties
    begin
      beers = YAML.load(File.read('./beers.yaml')) || []
      beers.delete_if { |beer| beer['id'] ==  self.id}
      beers << beer 
      file = File.write('./beers.yaml', YAML.dump(beers))
      true
    rescue
      false
    end
  end

  def self::find(id)
    beer = all_beers.detect do |beer|
      beer['id'] == id.to_i
    end

    Beer.new(beer) || []
  end

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
  def self::all_beers
    YAML.load(File.read('./beers.yaml')) || []
  end

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
end
