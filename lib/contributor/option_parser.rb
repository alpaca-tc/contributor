require 'optparse'
require 'erb'

module Contributor
  class OptionParser
    def initialize(argv)
      @original_argv = argv
      @argv = argv.dup
    end

    def parse!
      option_parser.parse!(@argv)
    end

    def option_parser
      @option_parser ||= ::OptionParser.new do |parser|
        parser.on('--repository GIT REPOSITORY PATH', String) do |path|
          Contributor.configuration.repository = path
        end

        parser.on('--configuration FILE', String) do |file|
          Contributor.configuration.yaml_file = file
        end

        parser.on_tail('--init', 'Initialize configuration file') do
          default = File.expand_path('../../../data/configuration.yml.default.erb', __FILE__)
          result = ERB.new(File.read(default), 0, '<>-').result
          File.write('configuration.yml', result)

          puts 'Create configuration.yml!!'
          exit
        end

        parser.on_tail('-h', '--help', 'Show this usage message and quit.') do |setting|
          puts parser.help
          exit
        end

        parser.on_tail('-v', '--version', 'Show version information about Contributor and quit.') do
          puts "Contributor v#{Version}"
          exit
        end
      end
    end
  end
end
