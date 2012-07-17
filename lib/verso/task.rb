module Verso
  class Task < Verso::Base
    include HTTPGettable
    attr_reader :code, :definition, :edition, :id, :sensitive, :statement,
      :questions
    alias sensitive? sensitive

    def essential
      sensitive ? true : method_missing(:essential)
    end
    alias essential? essential

    def standards
      @standards ||= StandardsList.new(method_missing(:goals))
    end
    alias goals standards

    def bare?
      definition.empty? && standards.sols.empty?
    end

  private

    def path
      "/courses/#{code},#{edition}/tasks/#{id}"
    end
  end
end
