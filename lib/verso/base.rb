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

    # Define methods to retrieve values from attribute hash
    #
    # @param attr [Symbol]
    def self.attr_reader(*attrs)
      attrs.each do |attr|
        class_eval do
          define_method attr do
            get_attr(attr.to_sym)
          end
        end
      end
    end

  protected

    def get_attr(attr)
      attrs.has_key?(attr) ? attrs[attr] : method_missing(attr)
    end
  end
end
