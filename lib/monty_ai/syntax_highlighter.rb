# frozen_string_literal: true

require "rouge"
require "pastel"

module MontyAI
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

      case extension
      when ".go"
        :go
      when ".rb"
        :ruby
      when ".js"
        :javascript
      when ".jsx"
        :react_javascript
      when ".py"
        :python
      when ".java"
        :java
      when ".php"
        :php
      when ".rs"
        :rust
      when ".ts"
        :typescript
      when ".tsx"
        :react_typescript
      else
        :text
      end
    end
  end
end
