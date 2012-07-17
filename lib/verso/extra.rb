module Verso
  class Extra < Verso::Base
    include HTTPGettable
    attr_reader :code, :description, :edition, :name, :title

  private

    def path
      "/courses/#{code},#{edition}/extras/#{name}"
    end

    def fetch
      super[:extra]
    end
  end
end
