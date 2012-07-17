module Verso
  class CredentialList < Verso::Base
    include Enumerable
    include HTTPGettable
    attr_reader :text

    def initialize(attrs={})
      attrs.symbolize_nested_keys!
      attrs[:text] = attrs[:text].to_s
      super attrs
    end

    def credentials
      @credentials ||= method_missing(:credentials).
        collect { |c| Credential.new(c) }.
        sort_by { |c| c.title }
    end

    def each &block
      credentials.each &block
    end

    def last
      credentials[-1]
    end

    def empty?
      credentials.empty?
    end

  private

    def path
      q_uri ||= Addressable::URI.new(:path => '/credentials')
      q_uri.query_values = { :text => text} unless text.empty?
      q_uri.request_uri
    end
  end
end
