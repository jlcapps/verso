module Verso
  class Task
    include HTTPGet

    def initialize(raw_task)
      @raw_task = raw_task
    end

    def method_missing(mname)
      if !@raw_task.has_key?(mname.to_s)
        @raw_task.merge!(JSON.parse(
          http_get("/courses/#{code},#{edition}/tasks/#{id}")
        ))
      end
      @raw_task[mname.to_s]
    end

    def essential
      sensitive ? true : @raw_task["essential"]
    end

    def standards
      @standards ||= StandardsList.new(goals)
    end

    def bare?
      definition.empty? && standards.sols.empty?
    end
  end
end
