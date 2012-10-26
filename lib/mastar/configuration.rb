# coding: utf-8
module Mastar
  class Configuration
    def initialize(options = {})
      opts = options.is_a?(Hash) ? options : {}
      [:name, :value, :key].each do |k|
        v = opts[k] || opts[k.to_s]
        __send__(k, v.to_sym) if v
      end
    end

    def name(name = nil)
      @name = name if name
      @name || :name
    end

    def value(value = nil)
      @value = value if value
      @value || :id
    end

    def key(key = nil)
      @key = key if key
      @key
    end
  end
end
