module Verso
  module HTTPGettable
  protected

    def get_attr(attr)
      attrs.merge!(fetch) unless attrs.has_key?(attr)
      super attr
    end

    def http_get
      Net::HTTP.get('api.cteresource.org', path, 80)
    end

    def fetch
      JSON.parse(http_get).symbolize_nested_keys!
    end
  end
end
