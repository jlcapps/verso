module Verso
  class Frontmatter
    include HTTPGet

    def initialize(opts)
      @raw_frontmatter = opts
    end

    def method_missing(mname)
      if !@raw_frontmatter.has_key?(mname.to_s)
        @raw_frontmatter = JSON.parse(
          http_get("/courses/#{@raw_frontmatter['code']},#{@raw_frontmatter['edition']}/frontmatter")
        )["frontmatter"]
      end
      @raw_frontmatter[mname.to_s]
    end
  end
end
