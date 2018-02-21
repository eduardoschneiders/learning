require 'json'

languages = {'1'=>'English', '2'=>'Spanish', '3'=>'French', '4'=>'German', '5'=>'Slavic', '6'=>'Other_Indo-European', '7'=>'Chinese', '8'=>'Arabic', '9'=>'Japanese_Turkish_Finnish_Magyar', '10'=>'Others'}
religions = {'0'=>'Catholic', '1'=>'Other Christian', '2'=>'Muslim', '3'=>'Buddhist', '4'=>'Hindu', '5'=>'Ethnic', '6'=>'Marxist', '7'=>'Others'}
zones = 	{'1'=>'NE', '2'=>'SE', '3'=>'SW', '4'=>'NW'}

data = JSON.parse(File.read('data_flags.json'))

data.each do |d| 
  d[2] = zones[d[2].to_s]
  #d[5] = languages[d[5].to_s]
  #d[6] = religions[d[6].to_s]
end

File.open('data_flags_2.json', 'a') { |f| f.write("[\n") }

data.each do |d|
  File.open('data_flags_2.json', 'a') do |f| 
  	f.write(d.to_json + ",\n")
  end
end

File.open('data_flags_2.json', 'a') { |f| f.write("]") }