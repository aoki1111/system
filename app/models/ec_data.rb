module EcData
  class Base < ActiveRecord::Base
    database = YAML.load(ERB.new(File.read('config/ec_data/database.yml')).result)
    establish_connection(database[Rails.env])
    self.abstract_class = true
  end
end
