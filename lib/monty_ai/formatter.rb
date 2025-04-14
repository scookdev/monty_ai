# frozen_string_literal: true

module MontyAI
  class Formatter
    def self.format(explanation, code = nil, filename = nil, options = {})
      # Default format is text
      format_type = options[:format] || "text"

      case format_type
      when "tty", "interactive"
        # Only use TTY UI if we're in a terminal and have code
        if $stdout.tty? && code
          ui = UI::Interface.new(code, explanation, filename)
          ui.render
          "" # Return empty string since UI outputs directly
        else
          # Fallback to text format if not in terminal
          format_as_text(explanation, code, filename)
        end
      when "text"
        format_as_text(explanation, code, filename)
      when "json"
        format_as_json(explanation, code, filename)
      else
        format_as_text(explanation, code, filename)
      end
    end

    def self.format_as_text(explanation, code = nil, filename = nil)
      # If no code is provided, just return the explanation
      return explanation unless code

      # Initialize highlighter
      highlighter = SyntaxHighlighter.new
      language = filename ? highlighter.detect_language(filename) : :text

      # Highlight the code
      highlighted_code = highlighter.highlight(code, language)

      # Format the output with highlighted code
      output = []
      output << "```"
      output << highlighted_code
      output << "```"
      output << ""
      output << "Explanation:"
      output << explanation

      output.join("\n")
    end

    def self.format_as_json(explanation, code = nil, filename = nil)
      require "json"

      result = {
        explanation: explanation
      }

      result[:code] = code if code
      result[:filename] = filename if filename

      JSON.pretty_generate(result)
    end
  end
end
