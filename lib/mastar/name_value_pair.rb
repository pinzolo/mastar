# coding: utf-8
module Mastar
  class NameValuePair
    attr_accessor :name, :value
    alias_method :first, :name
    alias_method :last, :value

    def initialize(name, value)
      @name = name
      @value = value
    end
  end
end
