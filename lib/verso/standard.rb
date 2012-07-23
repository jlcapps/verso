module Verso
  # Standard resource
  #
  # A standard that has been associated with a {Verso::Course}.
  #
  # @see http://api.cteresource.org/docs/courses/course/standards/standard
  #
  # @!attribute [r] code
  #   @return [String] Course code
  # @!attribute [r] edition
  #   @return [String] Course edition year
  # @!attribute [r] name
  #   @return [String] Standard name used as an identifier
  # @!attribute [r] title
  #   @return [String] Standard title
  #
  # @overload initialize(attrs={})
  #   @note Any attributes may be set upon instantiation, using Options Hash.
  #     The following are required:
  #   @option attrs [String] :code Course code *Required*
  #   @option attrs [String] :edition Edition year *Required*
  #   @option attrs [String] :name Standard name (identifier) *Required*
  class Standard < Verso::Base
   include HTTPGettable
    attr_reader :code, :edition, :name, :title

    # @return [String] description
    def description
      get_attr(:description).to_s # sometimes nil
    end

    # @return [Array] collection of goals with #title, #description strings
    def goals
      @goals ||= get_attr(:goals).
        collect { |raw_standard| OpenStruct.new(raw_standard) }
    end


    # @return [Array] collection of contained {Verso::Standard} objects
    def sections
      @sections ||= get_attr(:sections).
        collect do |raw_section|
          Standard.new(
            raw_section.merge(:code => code, :edition => edition, :name => name)
          )
        end
    end

  private

    def fetch
      super[:standard]
    end

    def path
      "/courses/#{code},#{edition}/standards/#{name}"
    end
  end
end
