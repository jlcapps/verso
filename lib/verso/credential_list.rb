module Verso
  # Credential list resource
  #
  # Search for {Verso::Credential} objects using free text, or get back the
  # list of all of them.
  #
  # @see http://api.cteresource.org/docs/credentials
  #
  # @example All
  #   creds = Verso::CredentialList.new # => everything
  #   creds.first # => <Verso::Credential:0x007fb1a39e4038 . . . >
  #
  # @example Search
  #   creds = Verso::CredentialList.new(:text => "nocti")
  #   creds.first.source.title # => "National Occupational Competency Testing Institute (NOCTI)"
  #
  # @overload initialize(attrs={})
  #   @option attrs [String] :text Free text
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
