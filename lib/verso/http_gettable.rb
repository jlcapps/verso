module Verso
  # Mixin for classes derived from {Verso::Base}. Provides the capability to
  # fetch the JSON resource to update attributes of the class.
  #
  # @abstract Implement a path method that gives the relative path of the
  #   corresponding JSON resource.
  module HTTPGettable
  protected

    # Get an attribute from the attributes store {#attrs}. Fetch  and merge
    # first if the attribute store doesn't have the key.
    #
    # @param [Symbol] attr The attribute key
    # @return [Object] The attribute
    def get_attr(attr)
      attrs.merge!(fetch) unless attrs.has_key?(attr)
      super attr
    end

    # HTTP GET the JSON resource
    # @return [String] JSON resource
    def http_get
      resp = Net::HTTP.get_response('api.cteresource.org', path, 80)
      if resp.code != "200"
        raise Verso::ResourceNotFoundError
      else
        resp.body
      end
    end

    # @return [Hash] Resource hash
    def fetch
      JSON.parse(http_get).symbolize_nested_keys!
    end
  end
end
