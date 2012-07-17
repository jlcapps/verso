module Verso
  class Credential
    include HTTPGettable

    def initialize(opts)
      @raw_credential = opts.symbolize_nested_keys!
    end

    def method_missing(mname)
      if @raw_credential[mname].nil?
        @raw_credential.merge!(
          JSON.parse(http_get("/credentials/#{id}"))["credential"].
          symbolize_nested_keys!
        )
      end
      @raw_credential[mname]
    end

    def source
      @source ||= OpenStruct.new(method_missing(:source))
    end

    def details
      @details ||= if @raw_credential.has_key?("details")
                     @raw_credential["details"]
                   else
                     method_missing(:details)
                   end.to_s
    end

    def related_courses
      method_missing(:related_courses).collect { |rc| Course.new(rc) }
    end
  end
end
