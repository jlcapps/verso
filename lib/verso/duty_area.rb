module Verso
  class DutyArea
    attr_accessor :title

    def initialize(raw_da)
      @title = raw_da["title"]
      @raw_tasks = raw_da["tasks"]
    end

    def tasks
      @tasks ||= @raw_tasks.collect { |t| Task.new(t) }
    end
  end
end
