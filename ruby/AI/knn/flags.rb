require 'json'

class Flags
  ATTRS = [
    'name',
    'landmass',
    'zone',
    'area',
    'population',
    'language',
    'religion',
    'bars',
    'stripes',
    'colours',
    'red',
    'green',
    'blue',
    'gold',
    'white',
    'black',
    'orange',
    'mainhue',
    'circles',
    'crosses',
    'saltires',
    'quarters',
    'sunstars',
    'crescent',
    'triangle',
    'icon',
    'animate',
    'text',
    'topleft',
    'botright',
  ]

  def self.train_data(*attributes)
    data.map do |d|
      attributes.map do |attr|
        d[ATTRS.index(attr)]
      end
    end
  end

  def self.data
    data = JSON.parse(File.read('data_flags.json'))
    data.select { |d| d.none? { |prop| prop == '?'} }
  end
end
