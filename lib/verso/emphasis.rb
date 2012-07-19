module Verso
  # Academic Emphasis resource
  #
  # @see http://api.cteresource.org/docs/academics/emphasis
  #
  # @!attribute [r] id
  #   @return [Fixnum] Academic Emphasis id
  # @!attribute [r] title
  #   @return Academic Emphasis title
  #
  # @overload initialize(attrs={})
  #   @note Any attributes may be set upon instantiation, using Options Hash.
  #     The following are required:
  #   @option attrs [Fixnum] :id Academic Emphasis id *Required*
  class Emphasis < Verso::Base
    include HTTPGettable
    attr_reader :id, :title

    # @return [Array] Collection of related {Verso::OccupationData} objects
    def occupation_data
      @occupation_data ||= get_attr(:occupation_data).
        collect { |od| OccupationData.new(od) }
    end

  private

    def fetch
      super[:emphasis]
    end

    def path
      "/academics/#{id}"
    end
  end
end
