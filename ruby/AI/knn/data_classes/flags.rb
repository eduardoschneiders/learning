require 'data_classes/main_class'

class Flags < MainClass
  def self.attrs
    [
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
  end

  def self.file_name
    'data_flags.json'
  end
end
