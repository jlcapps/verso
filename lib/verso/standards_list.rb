module Verso
  # Standards List resource
  #
  # A collection of {Verso::Standard} objects correlated to a {Verso::Course}.
  #
  # @see http://api.cteresource.org/docs/courses/course/standards
  #
  # @!attribute [r] code
  #   @return [String] Course code
  # @!attribute [r] edition
  #   @return [String] Course edition year
  #
  # @overload initialize(attrs={})
  #   @note Attributes required:
  #   @option attrs [String] :code Course code *Required*
  #   @option attrs [String] :edition Edition year *Required*
class StandardsList < Verso::Base
    include Enumerable
    include HTTPGettable
    extend Forwardable
    def_delegators :standards, :[], :each, :empty?, :last, :length
    attr_reader :code, :edition

    # @return [Array] Non-SOL standards in this list
    def non_sols
      @non_sols ||= reject { |s| sol_titles.include?(s.title) }
    end

    # @return [Array] SOL standards in this list
    def sols
      @sols ||= select { |s| sol_titles.include?(s.title) }
    end

    # Find Standards by {Verso::Course}.
    #
    # @param course [Verso::Course] A {Verso::Course}
    # @return [Verso::StandardsList] A {Verso::Course}'s standards
    def self.from_course(course)
      if course.related_resources.include?("standards")
        StandardsList.new(:code => course.code, :edition => course.edition)
      else
        StandardsList.new(:code => course.code, :edition => course.edition,
                          :standards => [])
      end
    end

  private

    def sol_titles
      ['English', 'History and Social Science', 'Mathematics', 'Science']
    end

    def standards
      @standards ||= get_attr(:standards).
        sort_by { |s| s[:title] }.
        collect do |raw_standard|
          Standard.new(raw_standard.merge(:code => code, :edition => edition))
        end
    end

    def path
      "/courses/#{code},#{edition}/standards/"
    end
  end
end
