module Verso
  # Extra resource
  #
  # An extra (or related material) associated with a Course framework in
  # Verso.
  #
  # @see http://api.cteresource.org/docs/courses/course/extras/extra
  #
  # @!attribute [r] code
  #   @return [String] Course code
  # @!attribute [r] edition
  #   @return [String] Edition year
  # @!attribute [r] name
  #   @return [String] Extra name, used as an identifier and not to
  #     be confused with its title, found by {Verso::ExtrasList}
  # @!attribute [r] description
  #   @return [String] HTML-formatted Extra description
  # @!attribute [r] title
  #   @return [String] Extra title
  #
  # @overload initialize(attrs={})
  #   @note Certain attributes are required for instantiation.
  #   @option attrs [String] :code Course code *Required*
  #   @option attrs [String] :edition Edition year *Required*
  #   @option attrs [String] :name Extra name *Required*
  class Extra < Verso::Base
    include HTTPGettable
    attr_reader :code, :description, :edition, :name, :title

  private

    def path
      "/courses/#{code},#{edition}/extras/#{name}"
    end

    def fetch
      super[:extra]
    end
  end
end
