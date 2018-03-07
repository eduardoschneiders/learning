require 'json'

class MainClass
  def self.train_data(*attributes)
    data.map do |d|
      attributes.map do |attr|
        if index = attrs.index(attr)
          d[index]
        else
          raise "Attr not foud: #{attr}"
        end
      end
    end
  end

  private

  def self.data
    data = JSON.parse(File.read("data_sources/#{file_name}"))
    data.select { |d| d.none? { |prop| prop == '?'} }
  end
end
