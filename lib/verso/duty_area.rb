module Verso
  class DutyArea
    attr_reader :title, :context

    def initialize(raw_da, context)
      raw_da.symbolize_nested_keys!
      @context = context
      @title = raw_da[:title]
      @raw_tasks = raw_da[:tasks]
    end

    def tasks
      @tasks ||= @raw_tasks.collect do |t|
        Task.new(t.merge(:code => context.code, :edition => context.edition))
      end
    end
  end
end
