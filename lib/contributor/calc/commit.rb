module Contributor
  module Calc
    class Commit
      COMMAND = "git shortlog -s -n --since=%{beginning_at} --until=%{end_at}"

      attr_reader :result

      def initialize
        @result = Hash.new { |h, k| h[k] = 0 }
      end

      def run
        authors = Contributor.configuration.authors

        execute_command.each do |name, count|
          author = authors.find { |author| author.alias_names.include?(name) }
          raise "Missing author configuration #{name}"  unless author
          @result[author] += count
        end
      end

      private

      def execute_command
        terms = Contributor.configuration.terms
        command = sprintf(
          COMMAND,
          beginning_at: terms['beginning_at'].to_s,
          end_at: terms['end_at'].to_s
        )

        list = `#{command}`.split("\n")
        list.each_with_object({}) do |line, memo|
          if /^\s*(?<count>\d+)\s*(?<name>.*)\s*$/ =~ line
            memo[name] = count.to_i
          end
        end
      end
    end
  end
end
