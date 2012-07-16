module Verso
  class ExtrasList
    attr_reader :code, :edition
    include Enumerable
    include HTTPGet

    def initialize(opts)
      @code, @edition = opts[:code], opts[:edition]
    end

    def extras
      @extras ||= JSON.parse(
        http_get("/courses/#{code},#{edition}/extras/")
      )["extras"].
        collect { |e| Extra.new(e.merge(:code => code, :edition => edition)) }
    end

    def each &block
      extras.each &block
    end
  end
end
