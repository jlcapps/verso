module Verso
  class SOLCorrelationList
    include Enumerable
    include HTTPGettable

    def initialize(context)
      @context = context
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
      @correlations ||= sol_names.collect do |name|
        JSON.parse(
          http_get("/courses/#{code},#{edition}/standards/#{name}/correlations")
        )["correlations"]
      end.flatten
    end

    def each &block
      count = 0
      tasklist.each do |da|
        da.tasks.each do |task|
          count += 1
          related = correlations.find_all { |c| c["id"] == task.id }
          if related.empty?
            next
          else
            related[1,related.count].each do |c|
              related.first["goals"].merge!(c["goals"])
            end
            related.first["number"] = count
            yield Task.new(related.first)
          end
        end
      end
    end
  end
end
