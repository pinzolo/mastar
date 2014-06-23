# coding: utf-8
require "coveralls"
require "simplecov"
SimpleCov.formatter = Coveralls::SimpleCov::Formatter
SimpleCov.start do
  add_filter '/active_record/'
  add_filter '/spec/'
  add_filter '/bundle/'
end

base_dir = File.dirname(__FILE__)
$:.unshift(base_dir, '/../lib')
require 'mastar'
require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => ':memory:'
)

ActiveRecord::Base.load(base_dir + '/schema.rb')
ActiveRecord::Base.load(base_dir + '/models.rb')

require 'yaml'
(1..4).to_a.each do |i|
  yml = YAML.load_file("#{base_dir}/fixtures/dows.yml")
  yml.keys.each do |k|
    eval("Dow#{i}.create(yml[k])")
  end
end
