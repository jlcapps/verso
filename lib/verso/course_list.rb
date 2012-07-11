module Verso
  class CourseList
    include Enumerable
    include HTTPGet

    def initialize(raw_query)
      @q_uri = Addressable::URI.new(
        :path => '/courses',
        :query_values => raw_query.
          select { |k, v| v }.
          reject { |k, v| v.to_s.empty? }
      )
    end

    def courses
      @courses ||= if @q_uri.query_values.values.any?
                     JSON.parse(http_get(@q_uri.request_uri))["courses"].
                       collect { |c| Course.new(c) }
                   else
                     []
                   end
    end

    def each &block
      courses.each &block
    end

    def last
      courses[-1]
    end

    def empty?
      courses.empty?
    end
  end
end
