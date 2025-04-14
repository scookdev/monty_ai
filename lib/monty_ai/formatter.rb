# frozen_string_literal: true

# lib/monty_ai/formatter.rb
module MontyAI
  class Formatter
    def self.format(explanation, code = nil, filename = nil)
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
  end
end
