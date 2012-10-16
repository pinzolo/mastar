# coding: utf-8
module Mastar
  # Mastar configuration class
  # this class has 3 parameters
  #   name  : column name of pair' name
  #   value : column name of pair' value
  #   key   : column name of unique key
  class Configuration

    # create new Configuration with Hash parameters
    # acceptable hash value type is String or Symbol
    # when value type is String, this class has converted to Symbol
    # hash key => value description
    #   :name  => column name of pair's name
    #   :value => column name of pair's value
    #   :key   => column name of unique key
    def initialize(options = {})
      opts = options.is_a?(Hash) ? options : {}
      [:name, :value, :key].each do |k|
        v = opts[k] || opts[k.to_s]
        send(k, v.to_sym) if v
      end
    end

    # get column name of pair's name
    # get :name(Symbol) when @name is null
    def name(name = nil)
      @name = name if name
      @name || :name
    end

    # get column name of pair's value
    # get :id(Symbol) when @value is null
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
