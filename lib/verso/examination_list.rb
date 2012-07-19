module Verso
  # Examination List resource
  #
  # A collection of Examination stand-in objects that respond to:
  # * #amt_seal @return [Boolean] AMT Seal
  # * #passing_score @return [String] Passing score
  # * #retired @return [Boolean] Slated to be deleted?
  # * #source @return [String] Title of exam source
  # * #title @return [String] Exam title
  # * #verified_credit @return [Booelean] Verified credit
  #
  # The attributes of the Examination stand-ins are similar to
  # {Verso::Credential}.
  #
  # @example Get the list
  #   exams = Verso::ExaminationList.new # => everything
  #   exams.first.title # => "Advanced Placement Computer Science A"
  #
  # @see http://api.cteresource.org/docs/examinations
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
