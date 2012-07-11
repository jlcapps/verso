module Verso
  class StandardsList
    include Enumerable

    def initialize(raw, context=nil)
      @raw_standards = raw.is_a?(Array) ? raw : raw.values
      @context = context
    end

    def self.from_course(course)
      raw_standards = JSON.parse(
        Net::HTTP.get('api.cteresource.org',
                      "/courses/#{course.code},#{course.edition}/standards/",
                      80)
      )["standards"]
      StandardsList.new(raw_standards, course)
    end

    def standards
      @standards ||= @raw_standards.
        sort_by { |s| s["title"] }.
        collect { |raw_standard| Standard.new(raw_standard, @context) }
    end

    def each &block
      standards.each &block
    end

    def last
      standards[-1]
    end

    def empty?
      standards.empty?
    end

    def sol_titles
      ['English', 'History and Social Science', 'Mathematics', 'Science']
    end

    def sols
      @sols ||= select { |s| sol_titles.include?(s.title) }
    end

    def non_sols
      @non_sols ||= reject { |s| sol_titles.include?(s.title) }
    end
  end
end
