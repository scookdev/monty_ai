# frozen_string_literal: true

require "thor"

module MontyAI
  class CLI < Thor
    desc "explain FILE", "Explain the code in FILE"
    def explain(file = nil)
      if file.nil? && !$stdin.tty?
        # Handle piped input
        code = $stdin.read
        handle_code(code)
      elsif file.nil?
        # No file provided and no pipe
        puts "Error: Please provide a file to explain or pipe code to the command."
        exit 1
      else
        # Handle file input
        begin
          code = FileHandler.read(file)
          handle_code(code, file)
        rescue Error => e
          puts "Error: #{e.message}"
          exit 1
        end
      end
    end

    private

    def handle_code(code, filename = nil)
      puts "Analyzing code..."

      begin
        explainer = AIClient.new
        explanation = explainer.explain_code(code)

        if filename
          puts "Explanation for #{filename}:"
          puts ""
        end

        puts Formatter.format(explanation)
      rescue Error => e
        puts "Error: #{e.message}"
        exit 1
      end
    end

    desc "version", "Show version"
    def version
      puts "MontyAI version #{MontyAI::VERSION}"
    end
  end
end
