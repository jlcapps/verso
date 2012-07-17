module Verso
  class CourseList < Verso::Base
    include Enumerable
    include HTTPGettable

    def courses
      @courses ||= if q_uri.query_values.values.any?
                     JSON.parse(http_get)["courses"].
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

  private

    def q_uri
      Addressable::URI.new(
        :path => '/courses',
        :query_values => attrs.
          select { |k, v| v }.
          reject { |k, v| v.to_s.empty? }
      )
    end

    def path
      q_uri.request_uri
    end
  end
end
