# coding: utf-8
require 'mastar/version'
require 'mastar/configuration'
require 'mastar/name_value_pair'

module Mastar
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def pairs(options = {})
      opts = safe_options(options)
      name = extract_option_value(opts, :name, mastar_config.name)
      value = extract_option_value(opts, :value, mastar_config.value)
      self.select([name, value]).map { |r| NameValuePair.new(r.__send__(name), r.__send__(value)) }
    end

    private
    def mastar(options = {})
      opts = safe_options(options)
      unless opts.empty?
        mastar_config.name(extract_option_value(opts, :name))
        mastar_config.value(extract_option_value(opts, :value))
        mastar_config.key(extract_option_value(opts, :key))
      end
      mastar_config
    end

    def mastar_config
      @mastar_config ||= Mastar::Configuration.new
    end

    def mastar_records
      @mastar_records ||= {}
    end

    def safe_options(options)
      options.is_a?(Hash) ? options : {}
    end

    def extract_option_value(options, key, default_value = nil)
      val = options[key] || options[key.to_s]
      val = val || default_value if default_value
      val.to_sym
    end

    def method_missing(name, *args)
      if mastar_config.key
        define_direct_method(name)
        respond_to?(name) ? __send__(name, *args) : nil
      else
        super
      end
    end

    def define_direct_method(name)
      rec = where(mastar_config.key => name.to_s).first
      return unless rec

      klass = class << self; self end
      klass.class_eval do
        eval("define_method(:#{name}_id) { #{rec.id} }")
        define_method(name) do |*args|
          record_id = __send__("#{name}_id")
          mastar_records[record_id] ||= rec
          record = mastar_records[record_id]
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
