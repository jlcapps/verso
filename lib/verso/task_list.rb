module Verso
  # Task List resource
  #
  # A collection of {Verso::DutyArea} objects containing the {Verso::Task}
  # objects for a {Verso::Course}
  #
  # @see http://api.cteresource.org/docs/courses/course/tasks
  #
  # @!attribute [r] code
  #   @return [String] Course code
  # @!attribute [r] edition
  #   @return [String] Course edition
  #
  # @overload initialize(attrs={})
  #   @note Attributes required:
  #   @option attrs [String] :code Course code *Required*
  #   @option attrs [String] :edition Edition year *Required*
  class TaskList < Verso::Base
    include Enumerable
    include HTTPGettable
    extend Forwardable
    def_delegators :duty_areas, :[], :each, :empty?, :last, :length
    attr_reader :code, :edition

    # @return [Boolean] Contains non-essential tasks?
    def has_optional_task?
      any? { |da| da.tasks.any? { |t| !t.essential } }
    end

    # @return [Boolean] Contains sensitive tasks?
    def has_sensitive_task?
      any? { |da| da.tasks.any? { |t| t.sensitive } }
    end

  private

    def duty_areas
      @duty_areas ||= begin
                        get_attr(:duty_areas).
                          collect do |da|
                            DutyArea.new(
                              da.merge!(:code => code, :edition => edition)
                            )
                          end
                      rescue NameError, Verso::ResourceNotFoundError
                        []
                      end
    end

    def path
      "/courses/#{code},#{edition}/tasks/"
    end
  end
end
