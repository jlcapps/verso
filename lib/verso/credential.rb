module Verso
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

    def contacts
      @contacts ||= get_attr(:contacts).collect { |c| OpenStruct.new(c) }
    end

    def contractor_name
      get_attr(:contractor_name).to_s
    end

    def details
      get_attr(:details).to_s # #to_s b/c API sometimes returns nil
    end

    def source
      # force update if we only have part of source
      attrs.merge!(fetch) unless attrs[:source] && attrs[:source].has_key?(:url)
      OpenStruct.new(get_attr(:source))
    end

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
