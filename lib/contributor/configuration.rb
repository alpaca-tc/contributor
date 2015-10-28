require 'yaml'

module Contributor
  class Configuration < Hash
    def load_configuration!
      yaml = YAML.load_file(yaml_file)
      self.authors = yaml['authors'].map { |key, values| Author.new(key, values) }
      self.terms = yaml['terms']
    end

    def method_missing(action, *args)
      if /^(?<method>.*)=$/ =~ action.to_s
        self.send(:[]=, *([method] + args))
      else
        self[action.to_s] ||= self.class.new
        self[action.to_s]
      end
    end
  end
end
