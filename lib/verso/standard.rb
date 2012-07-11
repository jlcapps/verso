module Verso
  class Standard
    include HTTPGet

    def initialize(raw_standard, context=nil)
      @raw_standard = raw_standard
      @context = context
    end

    def method_missing(mname)
      if !@raw_standard.has_key?(mname.to_s)
        @raw_standard.merge!(JSON.parse(
          http_get("/courses/#{code},#{edition}/standards/#{name}")
        )["standard"])
      end
      @raw_standard[mname.to_s]
    end

    def code
      @context && @context.code
    end

    def edition
      @context && @context.edition
    end

    def sections
      @sections ||= method_missing(:sections).
        collect { |raw_section| Standard.new(raw_section, @context) }
    end

    def goals
      @goals ||= method_missing(:goals).
        collect { |raw_standard| OpenStruct.new(raw_standard) }
    end
  end
end
