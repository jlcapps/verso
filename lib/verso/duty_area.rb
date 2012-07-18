module Verso
  class DutyArea < Verso::Base
    attr_reader :code, :edition, :title

    def tasks
      @tasks ||= get_attr(:tasks).collect do |t|
        Task.new(t.merge(:code => code, :edition => edition))
      end
    end
  end
end
