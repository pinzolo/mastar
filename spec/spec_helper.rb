# coding: utf-8
base_dir = File.dirname(__FILE__)
$:.unshift(base_dir, '/../lib')
require 'mastar'
require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => 'db/test.db'
)

ActiveRecord::Base.silence do
  load(base_dir + '/schema.rb')
  load(base_dir + '/models.rb')
end

require 'yaml'
[[Color, 'colors'], [Dow, 'dows'], [Month, 'months']].each do |klass, file_name|
  yml = YAML.load_file("#{base_dir}/fixtures/#{file_name}.yml")
  yml.keys.each do |k|
    klass.create(yml[k])
  end
end
