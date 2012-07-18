module Verso
  class Credential < Verso::Base
    include HTTPGettable
    attr_reader :id, :title, :type

    def source
      @source ||= OpenStruct.new(get_attr(:source))
    end

    def details
      get_attr(:details).to_s # #to_s b/c API sometimes returns nil
    end

    def related_courses
      get_attr(:related_courses).collect { |rc| Course.new(rc) }
    end

  private

    def path
      "/credentials/#{id}"
    end

    def fetch
      super[:credential]
    end
  end
end
