module Verso
  # Extras List resource
  #
  # A collection of {Verso::Extra} associated with a {Course} framework.
  #
  # @see http://api.cteresource.org/docs/courses/course/extras
  #
  # @example Get extras for 2012 edition of course 6320
  #   extras = Verso::ExtrasList.new(:code => "6320", :edition => "2012")
  #
  # @!attribute [r] code
  #   @return [String] Course code
  # @!attribute [r] edition
  #   @return [String] Edition year
  #
  # @overload initialize(attrs={})
  #   @note Certain attributes are required for instantiation.
  #   @option attrs [String] :code Course code *Required*
  #   @option attrs [String] :edition Edition year *Required*
 class ExtrasList < Verso::Base
    include Enumerable
    include HTTPGettable
    extend Forwardable
    attr_reader :code, :edition
    def_delegators :extras, :[], :each, :empty?, :last, :length

  private

    def extras
      @extras ||= get_attr(:extras).
        collect { |e| Extra.new(e.merge(:code => code, :edition => edition)) }
    end

    def path
      "/courses/#{code},#{edition}/extras/"
    end
  end
end
