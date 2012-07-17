module Verso
  class Base
    attr_reader :attrs
    alias to_hash attrs

    # Initialize new object
    #
    # @param attrs [Hash]
    # @return [Verso::Base]
    def initialize(attrs={})
      @attrs = attrs.symbolize_nested_keys!
    end

    def method_missing(mname)
      attrs.has_key?(mname) ? attrs[mname] : super
    end

    # Define methods to retrieve values from attribute hash
    #
    # @overload self.attr_reader(attr)
    #   @param attr [Symbol]
    def self.attr_reader(*attrs)
      attrs.each do |attr|
        class_eval do
          define_method attr do
            @attrs[attr.to_sym] || method_missing(attr.to_sym)
          end
        end
      end
    end
  end
end
