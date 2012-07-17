module Verso
  class ExtrasList < Verso::Base
    include Enumerable
    include HTTPGettable
    attr_reader :code, :edition

    def extras
      @extras ||= method_missing(:extras).
        collect { |e| Extra.new(e.merge(:code => code, :edition => edition)) }
    end

    def each &block
      extras.each &block
    end

  private

    def path
      "/courses/#{code},#{edition}/extras/"
    end
  end
end
