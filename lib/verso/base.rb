# A wrapper for the Virginia CTE Resource Center's Web API, providing access
# to Virginia's Career and Technical Education curriculum, course, and
# occupation data.
#
# @see http://api.cteresource.org/docs Web API documentation
module Verso
  # Classes derived from Verso::Base should define attr_readers or
  # appropriate methods (using Verso::Base#get_attr w/in methods) to access
  # attributes stored in the attrs hash.
  #
  # @!attribute [r] attrs
  #   attribute hash
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

    # Get attribute value from attrs attribute store or raise NoMethodError
    # if the key is not defined.
    #
    # @param attr [Symbol]
    # @return attribute value
    # @raise [NoMethodError]
    def get_attr(attr)
      attrs.has_key?(attr) ? attrs[attr] : method_missing(attr)
    end
  end
end
