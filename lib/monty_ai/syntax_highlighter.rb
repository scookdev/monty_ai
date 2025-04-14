# frozen_string_literal: true

require "rouge"
require "pastel"

module MontyAI
  # Class SyntaxHighlighter adds highlighting to code that's rendered
  class SyntaxHighlighter
    def initialize
      @pastel = Pastel.new
    end

    def highlight(code, language = :ruby)
      formatter = Rouge::Formatters::Terminal256.new(Rouge::Themes::Monokai.new)
      lexer = Rouge::Lexer.find(language.to_s) || Rouge::Lexers::PlainText.new
      formatter.format(lexer.lex(code))
    end

    def detect_language(filename)
      extension = File.extname(filename).downcase

      language_map = {
        ".go" => :go,
        ".rb" => :ruby,
        ".js" => :javascript,
        ".jsx" => :react_javascript,
        ".py" => :python,
        ".java" => :java,
        ".php" => :php,
        ".rs" => :rust,
        ".ts" => :typescript,
        ".tsx" => :react_typescript
      }

      language_map[extension] || :text
    end
  end
end
