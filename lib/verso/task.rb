module Verso
  # Task resource
  #
  # A {Verso::Course} task/competency contained by a {Verso::DutyArea} or
  # a {Verso::CorrelationList}.
  #
  # @!attribute [r] code
  #   @return [String] Course code
  # @!attribute [r] definition
  #   @return [String] HTML-formatted Task definition
  # @!attribute [r] edition
  #   @return [String] Course edition year
  # @!attribute [r] id
  #   @return [Fixnum] Task ID
  # @!attribute [r] sensitive
  #   @return [Boolean] Is this task sensitive?
  # @!attribute [r] statement
  #   @return [String] Task/competency statement
  # @!attribute [r] questions
  #   @return [String] HTML-formatted process/skill questions
  #
  # @overload initialize(attrs={})
  #   @note Any attributes may be set upon instantiation, using Options Hash.
  #     The following are required:
  #   @option attrs [String] :code Course code *Required*
  #   @option attrs [String] :edition Edition year *Required*
  #   @option attrs [String] :id Task ID *Required*
  class Task < Verso::Base
    include HTTPGettable
    attr_reader :code, :definition, :edition, :id, :sensitive, :statement,
      :questions
    alias sensitive? sensitive

    # @return [Boolean] Does this task have only a statement?
    def bare?
      definition.empty? && standards.sols.empty?
    end

    # @return [Boolean] Is this task considered essential?
    def essential
      sensitive ? true : get_attr(:essential)
    end
    alias essential? essential

    # @return [Verso::StandardsList] Standards related to this task
    def standards
      @standards ||= StandardsList.new(get_attr(:goals))
    end
    alias goals standards

  private

    def path
      "/courses/#{code},#{edition}/tasks/#{id}"
    end
  end
end
