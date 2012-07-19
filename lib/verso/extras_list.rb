module Verso
  class ExtrasList < Verso::Base
    include Enumerable
    include HTTPGettable
    extend Forwardable
    attr_reader :code, :edition
    def_delegators :extras, :[], :each, :empty?, :last, :length

  private

    def extras
      @extras ||= get_attr(:extras).
        collect { |e| Extra.new(e.merge(:code => code, :edition => edition)) }
    end

    def path
      "/courses/#{code},#{edition}/extras/"
    end
  end
end
