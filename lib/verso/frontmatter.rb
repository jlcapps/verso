module Verso
  class Frontmatter < Verso::Base
    include HTTPGettable
    attr_reader :acknowledgments_text, :attribution_block, :code,
      :copyright_year, :developed_by, :developed_for, :edition,
      :foreword_text, :introduction_text, :notice_block

  private

    def fetch
      super[:frontmatter]
    end

    def path
      "/courses/#{code},#{edition}/frontmatter"
    end
  end
end
