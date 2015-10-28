module Contributor
  class Author
    attr_reader :name

    def initialize(name, options = nil)
      options ||= {}

      @name = name
      @alias = if options['alias']
                 options['alias']
               else
                 []
               end
    end

    def alias_names
      [@name] + @alias
    end

    def alias_names_for_git
      alias_names.map { |v| v.gsub(/\s/, '\ ') }
    end
  end
end
