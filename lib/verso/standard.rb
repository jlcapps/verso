module Verso
  class Standard < Verso::Base
    include HTTPGettable
    attr_reader :code, :edition, :name, :title

    def description
      get_attr(:description).to_s # sometimes nil
    end

    def goals
      @goals ||= get_attr(:goals).
        collect { |raw_standard| OpenStruct.new(raw_standard) }
    end

    def sections
      @sections ||= get_attr(:sections).
        collect do |raw_section|
          Standard.new(
            raw_section.merge(:code => code, :edition => edition, :name => name)
          )
        end
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
