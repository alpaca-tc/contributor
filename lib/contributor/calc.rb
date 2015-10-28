require 'contributor/calc/crease'
require 'contributor/calc/commit'

module Contributor
  module Calc
    def self.run(argv)
      Contributor::OptionParser.new(argv).parse!
      Contributor.configuration.load_configuration!

      invoke(Calc::Crease)
      invoke(Calc::Commit)
    end

    def self.invoke(klass)
      calc = klass.new

      Dir.chdir(Contributor.configuration.repository) do
        calc.run
      end

      puts klass

      calc.result.each do |author, values|
        puts author.name
        puts values
      end

      puts '---'
    end
  end
end
