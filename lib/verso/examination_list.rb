module Verso
  class ExaminationList < Verso::Base
    include Enumerable
    include HTTPGettable
    extend Forwardable
    def_delegators :examinations, :[], :each, :empty?, :last, :length

  private

    def examinations
      @examinations ||= get_attr(:examinations).
                          collect { |e| OpenStruct.new(e) }
    end

    def path
      "/examinations/"
    end
  end
end
