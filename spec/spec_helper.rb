# coding: utf-8
base_dir = File.dirname(__FILE__)
$:.unshift(base_dir, '/../lib')
require 'mastar'
require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => ':memory:'
)

ActiveRecord::Base.silence do
  load(base_dir + '/schema.rb')
  load(base_dir + '/models.rb')
end

require 'yaml'
(1..4).to_a.each do |i|
  yml = YAML.load_file("#{base_dir}/fixtures/dows.yml")
  yml.keys.each do |k|
    eval("Dow#{i}.create(yml[k])")
  end
end
