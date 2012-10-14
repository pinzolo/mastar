# coding: utf-8
module Mastar
  # this class is simple container class, having only two String values(name, value).
  # and this has two alias methods for FormOptionsHelper#select in Rails.
  #   * first => name
  #   * last  => value
  class NameValuePair
    attr_accessor :name, :value
    alias_method :first, :name
    alias_method :last, :value

    # initialize with name and value
    def initialize(name, value)
      @name = name
      @value = value
    end
  end
end
