module Verso
  class Pathway < Verso::Base
    include HTTPGettable
    attr_reader :description, :id, :title

    def occupations
      @occupations ||= get_attr(:occupations).
        collect { |o| Occupation.new(o) }
    end

    def cluster
      @cluster ||= Cluster.new(get_attr(:cluster))
    end

  private

    def fetch
      super[:pathway]
    end

    def path
      "/pathways/#{id}"
    end
  end
end
