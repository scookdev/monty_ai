# frozen_string_literal: true

require "tty-box"
require "tty-screen"
require "tty-pager"
require "tty-spinner"
require "pastel"

module MontyAI
  module UI
    class Interface
      attr_reader :code, :explanation, :filename

      def initialize(code, explanation, filename = nil)
        @code = code
        @explanation = explanation
        @filename = filename
        @pastel = Pastel.new
        @highlighter = SyntaxHighlighter.new
      end

      def render
        width = TTY::Screen.width
        height = TTY::Screen.height

        # Calculate optimal box sizes based on terminal size
        code_height = [height * 0.5, 15].min.to_i
        explanation_height = [height * 0.3, 10].min.to_i

        # Determine language from filename if available
        language = @filename ? @highlighter.detect_language(@filename) : :text

        # Highlight the code
        highlighted_code = @highlighter.highlight(@code, language)

        # Create boxes for code and explanation
        render_header(width)
        render_code_box(highlighted_code, width, code_height)
        render_explanation_box(width, explanation_height)
        render_footer(width)
      end

      private

      def render_header(width)
        title = @filename ? "MontyAI: #{File.basename(@filename)}" : "MontyAI Code Explanation"

        box = TTY::Box.frame(
          width: width,
          height: 3,
          border: {
            type: :thick,
            top: true,
            bottom: true,
            left: true,
            right: true
          },
          align: :center,
          padding: [0, 1, 0, 1]
        ) do
          @pastel.cyan.bold(title)
        end

        puts box
      end

      def render_code_box(highlighted_code, width, height)
        # Get the first N lines that will fit in our display area
        code_lines = highlighted_code.split("\n")[0...(height - 2)]
        truncated_code = code_lines.join("\n")

        # Add indicator if code was truncated
        if code_lines.length < highlighted_code.split("\n").length
          # rubocop:disable Layout/LineLength, Style/StringConcatenation
          truncated_code += "\n" + @pastel.yellow("... (#{highlighted_code.split("\n").length - code_lines.length} more lines)")
          # rubocop:enable Layout/LineLength, Style/StringConcatenation
        end

        box = TTY::Box.frame(
          width: width,
          height: height + 2,
          border: {
            type: :thick,
            top: true,
            bottom: true,
            left: true,
            right: true
          },
          title: {
            top_left: @pastel.yellow.bold(" Code ")
          },
          padding: [1, 1, 1, 1]
        ) do
          truncated_code
        end

        puts box
      end

      def render_explanation_box(width, height)
        # Get the first N lines that will fit in our display area
        explanation_lines = @explanation.split("\n")[0...(height - 2)]
        truncated_explanation = explanation_lines.join("\n")

        # Add indicator if explanation was truncated
        if explanation_lines.length < @explanation.split("\n").length
          # rubocop:disable Layout/LineLength, Style/StringConcatenation
          truncated_explanation += "\n" + @pastel.yellow("... (#{@explanation.split("\n").length - explanation_lines.length} more lines)")
          # rubocop:enable Layout/LineLength, Style/StringConcatenation
        end

        box = TTY::Box.frame(
          width: width,
          height: height + 2,
          border: {
            type: :thick,
            top: true,
            bottom: true,
            left: true,
            right: true
          },
          title: {
            top_left: @pastel.green.bold(" Explanation ")
          },
          padding: [1, 1, 1, 1]
        ) do
          truncated_explanation
        end

        puts box
      end

      def render_footer(width)
        tips = "Tip: You can customize the output format with --format option"

        box = TTY::Box.frame(
          width: width,
          height: 3,
          border: {
            type: :thick,
            top: true,
            bottom: true,
            left: true,
            right: true
          },
          align: :center,
          padding: [0, 1, 0, 1]
        ) do
          @pastel.dim(tips)
        end

        puts box
      end
    end
  end
end
