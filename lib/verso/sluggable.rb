module Verso
  # Mixin for class, providing a slug method that returns a parameterized
  # version of the title, a la ActiveSupport::Inflector's String#parameterize.
  #
  # @abstract Implement a title method that returns a string.
  module Sluggable
    # @return [String] Parameterized title
    def slug
      # swiped from ActiveSupport::Inflector
      parameterized_string = title.dup
      parameterized_string.gsub!(/[^a-z0-9\-_]+/i, '-')
      re_sep = Regexp.escape('-')
      parameterized_string.gsub!(/#{re_sep}{2,}/, '-')
      parameterized_string.gsub!(/^#{re_sep}|#{re_sep}$/i, '')
      parameterized_string.downcase
    end
  end
end
