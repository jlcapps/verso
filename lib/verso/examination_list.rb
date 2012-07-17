module Verso
  class ExaminationList < Verso::Base
    include Enumerable
    include HTTPGettable

    def examinations
      @examinations ||= method_missing(:examinations).
        collect { |e| OpenStruct.new(e) }
    end

    def each &block
      examinations.each &block
    end

    def last
      examinations[-1]
    end

  private

    def path
      "/examinations/"
    end
  end
end
