module Verso
  class TaskList
    include Enumerable
    include HTTPGet

    attr_accessor :code, :edition

    def initialize(params)
      @code = params[:code]
      @edition = params[:edition]
    end

    def duty_areas
      @duty_areas ||= JSON.parse(
        http_get("/courses/#{code},#{edition}/tasks/")
      )["duty_areas"].to_a
    end

    def has_optional_task?
      any? { |da| da.tasks.any? { |t| !t.essential } }
    end

    def has_sensitive_task?
      any? { |da| da.tasks.any? { |t| t.sensitive } }
    end

    def each &block
      duty_areas.each { |da| block.call(DutyArea.new(da, self)) }
    end
  end
end
