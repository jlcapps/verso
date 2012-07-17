module Verso
  class CredentialList
    include Enumerable
    include HTTPGettable

    attr_reader :credentials

    def initialize(opts={})
      @q_uri = Addressable::URI.new(:path => '/credentials')
      @q_uri.query_values = opts unless opts[:text].to_s.empty?
      @credentials = JSON.parse(http_get(@q_uri.request_uri))["credentials"].
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
  end
end
