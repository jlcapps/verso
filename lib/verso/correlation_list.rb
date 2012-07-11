module Verso
  class CorrelationList
    include Enumerable
    include HTTPGet

    def initialize(context, name)
      @context = context
      @name = name
    end

    def title
      @title ||= @context.standards.find { |s| s.name == @name }.title
    end

    def code
      @context.code
    end

    def edition
      @context.edition
    end

    def tasklist
      @context.duty_areas
    end

    def sol_names
      @sol_names ||= @context.standards.sols.collect { |s| s.name }
    end

    def correlations
      @correlations ||= JSON.parse(
        http_get("/courses/#{code},#{edition}/standards/#{@name}/correlations")
      )["correlations"]
    end

    def each &block
      count = 0
      tasklist.each do |da|
        da.tasks.each do |task|
          count += 1
          related = correlations.find { |c| c["id"] == task.id }
          if related.nil?
            next
          else
            related["number"] = count
            yield Task.new(related)
          end
        end
      end
    end
  end
end
