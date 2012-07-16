module Verso
  class Extra
    include HTTPGet

    def initialize(raw_extra)
      @raw_extra = raw_extra.symbolize_nested_keys!
    end

    def code
      @raw_extra[:code]
    end

    def edition
      @raw_extra[:edition]
    end


    def name
      @raw_extra[:name]
    end


    def title
      @raw_extra[:title]
    end

    def description
      if @raw_extra[:description].nil?
        @raw_extra.merge!(
          JSON.parse(
            http_get("/courses/#{code},#{edition}/extras/#{name}")
          )["extra"].symbolize_nested_keys!
        )
      end
      @raw_extra[:description]
    end
  end
end
