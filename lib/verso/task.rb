module Verso
  class Task
    include HTTPGettable

    def initialize(raw_task)
      @raw_task = raw_task.symbolize_nested_keys!
    end

    def method_missing(mname)
      if !@raw_task.has_key?(mname)
        @raw_task.merge!(JSON.parse(
          http_get("/courses/#{code},#{edition}/tasks/#{id}")
        ).symbolize_nested_keys!)
      end
      @raw_task[mname]
    end

    def essential
      sensitive ? true : @raw_task[:essential]
    end

    def standards
      @standards ||= StandardsList.new(goals)
    end

    def bare?
      definition.empty? && standards.sols.empty?
    end
  end
end
