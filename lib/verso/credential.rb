module Verso
  # Credential Resource
  #
  # The usual way to get a Credential would be to use {Verso::CredentialList}
  # or to get one from a related object, such as a {Verso::Course} object.
  #
  # @see http://api.cteresource.org/docs/credentials/credential
  #
  # @!attribute [r] admin_notes
  #   @return [String] HTML-formatted test administration notes
  # @!attribute [r] amt_seal
  #   @return [Booelean] Advanced Math and Technology seal
  # @!attribute [r] contact_info
  #   @return [String] Contractor contact information
  # @!attribute [r] cost
  #   @return [String] Cost
  # @!attribute [r] cte_seal
  #   @return [Boolean] CTE seal
  # @!attribute [r] description
  #   @return [String] HTML-formatted text describing the credential.
  # @!attribute [r] has_ancestor
  #   @return [Boolean] Did this credential exist in an earlier edition?
  # @!attribute [r] how_to_earn_it
  #   @return [String] HTML-formatted text about how to earn it.
  # @!attribute [r] id
  #   @return [Fixnum] Credential id
  # @!attribute [r] items
  #   @return [String] Number of test items
  # @!attribute [r] pretest
  #   @return [Boolean,nil] Is a pre-test, study guide, or blueprint available?
  # @!attribute [r] proctor
  #   @return [String] Test examiner/proctor
  # @!attribute [r] program_area
  #   @return [String] Title of associated program area
  # @!attribute [r] retired
  #   @return [Boolean] Is this credential slated for deletion?
  # @!attribute [r] site
  #   @return [String] Allowed testing site
  # @!attribute [r] time
  #   @return [String] Time allowed
  # @!attribute [r] title
  #   @return [String] Credential title
  # @!attribute [r] type
  #   @return ['Certification','License'] Credential type
  # @!attribute [r] verified_credit
  #   @return [Boolean] Verified credit
  #
  # @overload initialize(attrs={})
  #   @note Any attributes may be set upon instantiation, using Options Hash.
  #     The following are required:
  #   @option attrs [Fixnum] :id Credential id *Required*
  class Credential < Verso::Base
    include HTTPGettable
    attr_reader :admin_notes, :amt_seal, :contact_info, :cost, :cte_seal,
      :description, :has_ancestor, :how_to_earn_it, :id, :items, :pretest,
      :proctor, :program_area, :retired, :site, :time, :title, :type,
      :verified_credit
    alias amt_seal? amt_seal
    alias cte_seal? cte_seal
    alias has_ancestor? has_ancestor
    alias retired? retired
    alias verified_credit? verified_credit

    # VDOE contacts, each responding to #name, #email, and #phone, all Strings.
    #
    # @return [Array] VDOE contacts
    def contacts
      @contacts ||= get_attr(:contacts).collect { |c| OpenStruct.new(c) }
    end

    # @return [String] Contractor name
    def contractor_name
      get_attr(:contractor_name).to_s
    end

    # @return [String] Details
    def details
      get_attr(:details).to_s # #to_s b/c API sometimes returns nil
    end

    # Source. Responds to #title, #url, and #contact_info. All are Strings.
    # The last is HTML-formatted.
    #
    # @return [OpenStruct] Source
    def source
      # force update if we only have part of source
      attrs.merge!(fetch) unless attrs[:source] && attrs[:source].has_key?(:url)
      OpenStruct.new(get_attr(:source))
    end

    # @return [Array] Collection of related {Verso::Course} objects
    def related_courses
      @courses ||= get_attr(:related_courses).collect { |rc| Course.new(rc) }
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
