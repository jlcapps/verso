module Verso
  class Credential < Verso::Base
    include HTTPGettable
    attr_reader :id

    def source
      @source ||= OpenStruct.new(method_missing(:source))
    end

    def details
      method_missing(:details).to_s # API sometimes returns nil
    end

    def related_courses
      method_missing(:related_courses).collect { |rc| Course.new(rc) }
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
