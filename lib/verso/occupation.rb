module Verso
  class Occupation < Verso::Base
    include HTTPGettable
    attr_reader :description, :id, :title

    def pathway
      @pathway ||= Pathway.new(get_attr(:pathway))
    end

    def related_courses
      @related_courses ||= get_attr(:related_courses).
                             collect { |c| Course.new(c) }
    end

  private

    def fetch
      super[:occupation]
    end

    def path
      "/occupations/#{id}"
    end
  end
end
