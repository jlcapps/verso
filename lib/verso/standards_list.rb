module Verso
  class StandardsList < Verso::Base
    include Enumerable
    include HTTPGettable
    extend Forwardable
    def_delegators :standards, :[], :each, :empty?, :last, :length
    attr_reader :code, :edition

    def non_sols
      @non_sols ||= reject { |s| sol_titles.include?(s.title) }
    end

    def sols
      @sols ||= select { |s| sol_titles.include?(s.title) }
    end

    def self.from_course(course)
      StandardsList.new(:code => course.code, :edition => course.edition)
    end

  private

    def sol_titles
      ['English', 'History and Social Science', 'Mathematics', 'Science']
    end

    def standards
      @standards ||= get_attr(:standards).
        sort_by { |s| s[:title] }.
        collect do |raw_standard|
          Standard.new(raw_standard.merge(:code => code, :edition => edition))
        end
    end

    def path
      "/courses/#{code},#{edition}/standards/"
    end
  end
end
