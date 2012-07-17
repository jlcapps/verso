module Verso
  class Frontmatter < Verso::Base
    include HTTPGettable
    attr_reader :code, :edition

  private

    def fetch
      super[:frontmatter]
    end

    def path
      "/courses/#{code},#{edition}/frontmatter"
    end
  end
end
