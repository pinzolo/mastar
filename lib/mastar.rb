# coding: utf-8
require 'mastar/version'
require 'mastar/configuration'
require 'mastar/name_value_pair'

module Mastar
  def self.included(base)
    base.extend(ClassMethods)
    base.__send__(:include, InstanceMethods)
  end

  module ClassMethods
    def pairs(options = {})
      opts = options.is_a?(Hash) ? options : {}
      name = (opts[:name] || opts['name'] || mastar_config.name).to_sym
      value = (opts[:value] || opts['value'] || mastar_config.value).to_sym
      self.select([name, value]).map { |r| NameValuePair.new(r.send(name), r.send(value)) }
    end

    def mastar_name(attr)
      mastar_config.name = attr.to_sym if attr
    end

    def mastar_value(attr)
      mastar_config.value = attr.to_sym if attr
    end

    def mastar_config
      @mastar_config ||= Mastar::Configuration.new
    end
  end

  module InstanceMethods
  end
end
