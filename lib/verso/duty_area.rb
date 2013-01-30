module Verso
  # Duty Area
  #
  # A group of tasks in a {Verso::TaskList}.
  #
  # @see http://api.cteresource.org/docs/courses/course/tasks
  #
  # @!attribute [r] code
  #   @return [String] Course code
  # @!attribute [r] edition
  #   @return [String] Course edition year
  # @!attribute [r] id
  #   @return [String] DutyArea ID
  # @!attribute [r] title
  #   @return [String] Duty Area title
  #
  # @note A DutyArea is created for you by {Verso::TaskList}. It corresponds
  #   to a portion of the Task List resource. You should never need to
  #   instantiate one yourself.
  class DutyArea < Verso::Base
    attr_reader :code, :edition, :id, :title

    # Tasks within this Duty Area
    #
    # @return [Array] {Verso::Task} objects
    def tasks
      @tasks ||= get_attr(:tasks).collect do |t|
        Task.new(t.merge(:code => code, :edition => edition))
      end
    end
  end
end
