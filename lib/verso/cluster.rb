module Verso
  class Cluster < Verso::Base
    include HTTPGettable
    attr_reader :code, :description, :id, :postsecondary_info, :title

    def title
      @title ||= attrs[:title] || attrs[:cluster][:title]
    end

    def contact
      @contact ||= OpenStruct.new(get_attr(:contact))
    end

    def slug
      title.parameterize
    end

    def pathways
      @pathways ||= get_attr(:pathways).
        collect { |p| Pathway.new(p) }
    end

    def courses
      @courses ||= CourseList.new(:cluster => slug.gsub('-', ' ')).
                     sort_by { |c| c.title + c.edition }.
                     uniq { |c| c.code + c.edition }
    end

  private

    def fetch
      super[:cluster]
    end

    def path
      "/clusters/#{id}"
    end
  end
end
