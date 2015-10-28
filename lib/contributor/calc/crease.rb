module Contributor
  module Calc
    class Crease
      COMMAND = {
        additional: "git log --author='%{author}' --since=%{beginning_at} --until=%{end_at} --oneline --numstat --no-merges --pretty=format:"" | cut -f1 | awk 'BEGIN {sum=0} {sum+=$1} END {print sum}'",
        deletional: "git log --author='%{author}' --since=%{beginning_at} --until=%{end_at} --oneline --numstat --no-merges --pretty=format:"" | cut -f2 | awk 'BEGIN {sum=0} {sum+=$1} END {print sum}'"
      }.freeze

      attr_reader :result

      def initialize
        @result = Hash.new { |h, k| h[k] = { additional: 0, deletional: 0 } }
      end

      def run
        authors = Contributor.configuration.authors
        terms = Contributor.configuration.terms

        authors.each do |author|
          author.alias_names_for_git.each do |name|
            COMMAND.each do |key, command|
              command = sprintf(
                command,
                author: name,
                beginning_at: terms['beginning_at'].to_s,
                end_at: terms['end_at'].to_s
              )

              @result[author][key] += `#{command}`.strip.to_i
            end
          end
        end

        @result.each do |author, values|
          if values[:additional].zero? && values[:deletional].zero?
            @result.delete(author)
          else
            @result[author] = "+#{values[:additional]}, -#{values[:deletional]}"
          end
        end
      end
    end
  end
end
