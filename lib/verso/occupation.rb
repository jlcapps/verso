module Verso
  class Occupation
    include HTTPGet

    def initialize(raw_occupation)
      @raw_occupation = raw_occupation
    end

    def method_missing(mname)
      if @raw_occupation[mname.to_s].nil?
        @raw_occupation = JSON.parse(http_get("/occupations/#{id}"))["occupation"]
      end
      @raw_occupation[mname.to_s]
    end

    def related_courses
      @related_courses ||= method_missing(:related_courses).
        collect { |c| Course.new(c) }
    end

    def pathway
      @pathway ||= Pathway.new(method_missing(:pathway))
    end
  end
end
