# coding: utf-8
require 'mastar/version'
require 'mastar/configuration'
require 'mastar/name_value_pair'

module Mastar
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    # get NameValuePair array
    # options accepts name and value keys
    # options are first preference
    def pairs(options = {})
      opts = safe_options(options)
      name = extract_option_value(opts, :name, mastar_config.name)
      value = extract_option_value(opts, :value, mastar_config.value)
      self.select([name, value]).map { |r| NameValuePair.new(r.__send__(name), r.__send__(value)) }
    end

    # set configuration name, value, key at a time
    def mastar(options = {})
      opts = safe_options(options)
      mastar_name(extract_option_value(opts, :name))
      mastar_value(extract_option_value(opts, :value))
      mastar_key(extract_option_value(opts, :key))
    end

    # set name configuration
    def mastar_name(attr)
      mastar_config.name = attr.to_sym if attr
    end

    # set value configuration
    def mastar_value(attr)
      mastar_config.value = attr.to_sym if attr
    end

    # set value configuration
    def mastar_key(attr)
      mastar_config.key = attr.to_sym if attr
    end

    # get configuration instance
    def mastar_config
      @mastar_config ||= Mastar::Configuration.new
    end

    # if key configuration exists, define method of name and call
    def method_missing(name, *args)
      if mastar_config.key
        define_direct_method(name)
        __send__(name, *args)
      else
        super
      end
    end

    private
    # if options is Hash, return options
    # else return initialized Hash
    def safe_options(options)
      options.is_a?(Hash) ? options : {}
    end

    # get value as Symbol from options, the value associated with the key.
    # If the value obtained is nil, return default_value if it is specified.
    def extract_option_value(options, key, default_value = nil)
      val = options[key] || options[key.to_s]
      if default_value
        val = val || default_value
      end
      val.to_sym
    end

    # define method having following features.
    #  * when argument is single attribute name, return attribute value at direct.
    #  * when argument is attribute names, return array of attribute values at direct.
    #  * when no argument, return record instance.
    def define_direct_method(name)
      @mastar_records ||= {}
      klass = class << self; self end
      klass.class_eval do
        define_method(name) do |*args|
          @mastar_records[name] ||= where(mastar_config.key => name.to_s).first
          record = @mastar_records[name]
          if args.nil? || args.empty? || record.nil?
            record
          elsif args.length == 1
            record.__send__(args.first)
          else
            args.map { |arg| record.__send__(arg) }
          end
        end
      end
    end
  end
end
