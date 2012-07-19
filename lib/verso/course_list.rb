module Verso
  class CourseList < Verso::Base
    include Enumerable
    include HTTPGettable
    extend Forwardable
    def_delegators :courses, :[], :each, :empty?, :last, :length

    def courses
      @courses ||= if q_uri.query_values.values.any?
                       get_attr(:courses).collect { |c| Course.new(c) }
                   else
                     []
                   end
    end

  private

    def q_uri
      Addressable::URI.new(
        :path => '/courses',
        :query_values => attrs.
          reject { |k, v| k == :courses }.
          select { |k, v| v }.
          reject { |k, v| v.to_s.empty? }
      )
    end

    def path
      q_uri.request_uri
    end
  end
end
