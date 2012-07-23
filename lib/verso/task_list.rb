module Verso
  class TaskList < Verso::Base
    include Enumerable
    include HTTPGettable
    extend Forwardable
    def_delegators :duty_areas, :[], :each, :empty?, :last, :length
    attr_reader :code, :edition

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

    def duty_areas
      @duty_areas ||= begin
                        get_attr(:duty_areas).
                          collect do |da|
                            DutyArea.new(
                              da.merge!(:code => code, :edition => edition)
                            )
                          end
                      rescue NameError
                        []
                      end
    end

    def path
      "/courses/#{code},#{edition}/tasks/"
    end
  end
end
