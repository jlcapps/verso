module Verso
  # Search Verso courses by :text, :cluster, :program_area, :code, :edition,
  # or any combination and get back an Array-like collection of
  # {Verso::Course} objects.
  #
  # @see http://api.cteresource.org/docs/courses
  #
  # @example Search by text
  #   courses = Verso::CourseList.new(:text => "golf") # => <Verso::CourseList:0x007fa5a10bbb68 @attrs={:text=>"golf"}>
  #   courses.first.title # => "Turf Grass Applications, Advanced"
  #
  # @example Search by cluster
  #   course = Verso::CourseList.new(:cluster => "Information Technology).first
  #   course.title # => "Computer Applications"
  #
  # @example Search by program area
  #   course = Verso::CourseList.new(:program_area => "Career Connections").last
  #   course.title # => "Career Investigation Phase I"
  #
  # @example Search by code
  #   courses = Verso::CourseList.new(:code => "6320") # => <Verso::CourseList:0x007fa5a1f27a08 @attrs={:code=>"6320"}>
  #   courses.first # => <Verso::Course:0x007fa5a1f3e5c8 @attrs={:duration=>36, :edition=>"2012", :code=>"6320" . . . }>
  #   courses.first.code # => "6320"
  #
  # @example Search by edition
  #   all_2012 = Verso::CourseList.new(:edition => "2012")
  #
  # @example Search by combination
  #   courses = Verso::CourseList.new(:text => "internet", :cluster => "Marketing") # => <Verso::CourseList:0x007fa5a19b6c90 @attrs={ . . . }>
  #   courses.count # => 1
  #
  # @example An empty search returns an empty list
  #   courses = Verso::CourseList.new
  #   courses.count # => 0
  #
  # @overload initialize(attrs={})
  #   @option attrs [String] :code Course code
  #   @option attrs [String] :edition Edition year
  #   @option attrs [String] :text Free text
  #   @option attrs [String] :cluster Cluster title
  #   @option attrs [String] :program_area Program Area title
  class CourseList < Verso::Base
    include Enumerable
    include HTTPGettable
    extend Forwardable
    def_delegators :courses, :[], :each, :empty?, :last, :length

    private

    def courses
      @courses ||= if q_uri.query_values.values.any?
                       get_attr(:courses).collect { |c| Course.new(c) }
                   else
                     []
                   end
    end

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
