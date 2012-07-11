module Verso
  module HTTPGet
  protected

    def http_get(path)
      Net::HTTP.get('api.cteresource.org', path, 80)
    end
  end
end
