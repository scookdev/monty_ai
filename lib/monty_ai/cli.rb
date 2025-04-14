# frozen_string_literal: true

require "thor"

module MontyAI
  class CLI < Thor
    desc "explain FILE", "Explain the code in FILE"
    option :format, type: :string, default: "auto",
                    desc: "Output format (auto, text, tty, json)"
    def explain(file = nil)
      if file.nil? && !$stdin.tty?
        # Handle piped input
        code = $stdin.read
        handle_code(code)
      elsif file.nil?
        # No file provided and no pipe
        puts "Error: Please provide a file to explain or pipe code to the command."
        exit 1 unless ENV["RSPEC_RUNNING"]
        nil
      else
        # Handle file input
        begin
          code = FileHandler.read(file)
          handle_code(code, file)
        rescue Error => e
          puts "Error: #{e.message}"
          exit 1 unless ENV["RSPEC_RUNNING"]
          nil
        end
      end
    end

    private

    def handle_code(code, filename = nil)
      # Determine format
      format = options[:format]

      # If format is "auto", use TTY if in terminal, otherwise text
      if format == "auto"
        format = $stdout.tty? ? "tty" : "text"
      end

      # Show spinner only in TTY mode
      if format == "tty" && $stdout.tty?
        spinner = TTY::Spinner.new("[:spinner] Analyzing code...", format: :dots)
        spinner.auto_spin
      end

      explainer = AIClient.new
      explanation = explainer.explain_code(code)

      # Stop spinner if it exists
      spinner.stop if defined?(spinner) && spinner

      if filename && format != "json"
        puts "Explanation for #{filename}:" unless format == "tty"
        puts "" unless format == "tty"
      end

      formatted_output = Formatter.format(explanation, code, filename, { format: format })
      puts formatted_output unless formatted_output.empty?

      true
    rescue Error => e
      puts "Error: #{e.message}"
      exit 1 unless ENV["RSPEC_RUNNING"]
      false
    end

    desc "version", "Show version"
    def version
      puts "MontyAI version #{MontyAI::VERSION}"
    end
  end
end
