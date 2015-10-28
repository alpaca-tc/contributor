require 'contributor/version'
require 'contributor/author'
require 'contributor/option_parser'
require 'contributor/configuration'
require 'contributor/calc'

module Contributor
  def self.configuration
    @configuration ||= Configuration.new
  end
end
