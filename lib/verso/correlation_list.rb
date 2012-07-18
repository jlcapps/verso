module Verso
  class CorrelationList < Verso::Base
    include Enumerable
    include HTTPGettable
    extend Forwardable
    def_delegators :correlations, :[], :each, :empty?, :last, :length
    attr_reader :code, :edition, :name

    def title
      @title ||= first.goals.first.title
    end

  private

    def correlations
      @correlations ||= get_attr(:correlations).collect { |c| Task.new(c) }
    end

    def path
      "/courses/#{code},#{edition}/standards/#{name}/correlations"
    end
  end
end
