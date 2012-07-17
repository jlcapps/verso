module Verso
  module HTTPGettable
    def method_missing(mname)
      unless attrs.has_key?(mname)
        attrs.merge!(fetch)
      end
      attrs.has_key?(mname) ? attrs[mname] : super
    end

  protected

    def http_get
      Net::HTTP.get('api.cteresource.org', path, 80)
    end

    def fetch
      JSON.parse(http_get).symbolize_nested_keys!
    end
  end
end
