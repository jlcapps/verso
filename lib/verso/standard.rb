module Verso
  class Standard < Verso::Base
    include HTTPGettable
    attr_reader :description, :name, :title

    def initialize(attrs, context=nil)
      @context = context
      super attrs
    end

    def code
      @context && @context.code
    end

    def edition
      @context && @context.edition
    end

    def sections
      @sections ||= get_attr(:sections).
        collect { |raw_section| Standard.new(raw_section, @context) }
    end

    def goals
      @goals ||= get_attr(:goals).
        collect { |raw_standard| OpenStruct.new(raw_standard) }
    end

  private

    def fetch
      super[:standard]
    end

    def path
      "/courses/#{code},#{edition}/standards/#{name}"
    end
  end
end
