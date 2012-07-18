module Verso
  class Task < Verso::Base
    include HTTPGettable
    attr_reader :code, :definition, :edition, :id, :sensitive, :statement,
      :questions
    alias sensitive? sensitive

    def bare?
      definition.empty? && standards.sols.empty?
    end

    def essential
      sensitive ? true : get_attr(:essential)
    end
    alias essential? essential

    def number
      attrs[:number]
    end

    def standards
      @standards ||= StandardsList.new(get_attr(:goals))
    end
    alias goals standards

  private

    def path
      "/courses/#{code},#{edition}/tasks/#{id}"
    end
  end
end
