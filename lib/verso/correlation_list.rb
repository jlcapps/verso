module Verso
  # Correlation List Resource
  #
  # A crosswalk of competencies to standards body goals.
  # @see http://api.cteresource.org/docs/courses/course/standards/standard/correlations
  #
  # @!attribute [r] code
  #   @return [String] Course code
  # @!attribute [r] edition
  #   @return [String] Edition year
  # @!attribute [r] name
  #   @return [String] Standards Body name, used as an identifier and not to
  #     be confused with is title
  #
  # @overload initialize(attrs={})
  #   @note Certain attributes are required for instantiation.
  #   @option attrs [String] :code Course code *Required*
  #   @option attrs [String] :edition Edition year *Required*
  #   @option attrs [String] :name Standards Body name *Required*
  class CorrelationList < Verso::Base
    include Enumerable
    include HTTPGettable
    extend Forwardable
    def_delegators :correlations, :[], :each, :empty?, :last, :length
    attr_reader :code, :edition, :name

    # @return [String] Standards body title
    def title
      @title ||= first.goals.first.title
    end

  private

    def correlations
      @correlations ||= get_attr(:correlations).collect { |c| Task.new(c) }
    end

    def path
      "/courses/#{code},#{edition}/standards/#{name}/correlations"
    end
  end
end
