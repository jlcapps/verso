module Verso
  class TaskList < Verso::Base
    include Enumerable
    include HTTPGettable
    attr_reader :code, :edition

    def duty_areas
      @duty_areas ||= begin
                        get_attr(:duty_areas).
                          collect do |da|
                            DutyArea.new(
                              da.merge!(:code => code, :edition => edition)
                            )
                          end
                      rescue NoMethodError
                        []
                      end
    end

    def has_optional_task?
      any? { |da| da.tasks.any? { |t| !t.essential } }
    end

    def has_sensitive_task?
      any? { |da| da.tasks.any? { |t| t.sensitive } }
    end

    def each &block
      duty_areas.each { |da| block.call(da) }
    end

  private

    def path
      "/courses/#{code},#{edition}/tasks/"
    end
  end
end
