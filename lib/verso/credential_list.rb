module Verso
  class CredentialList < Verso::Base
    include Enumerable
    include HTTPGettable
    extend Forwardable
    def_delegators :credentials, :[], :each, :empty?, :last, :length

  private

    def credentials
      @credentials ||= get_attr(:credentials).
        collect { |c| Credential.new(c) }.
        sort_by { |c| c.title }
    end

    def path
      q_uri ||= Addressable::URI.new(:path => '/credentials')
      q_uri.query_values = { :text => text } unless text.empty?
      q_uri.request_uri
    end

    def text
      attrs[:text] ? attrs[:text] : ''
    end
  end
end
