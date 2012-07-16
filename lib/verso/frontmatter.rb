module Verso
  class Frontmatter
    include HTTPGet

    def initialize(opts)
      @raw_frontmatter = opts.symbolize_nested_keys!
    end

    def method_missing(mname)
      if !@raw_frontmatter.has_key?(mname)
        @raw_frontmatter = JSON.parse(
          http_get(
            "/courses/#{@raw_frontmatter[:code]},#{@raw_frontmatter[:edition]}/frontmatter")
        )["frontmatter"].symbolize_nested_keys!
      end
      @raw_frontmatter[mname]
    end
  end
end
