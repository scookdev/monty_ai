# frozen_string_literal: true

require "monty_ai/version"
require "monty_ai/cli"
require "monty_ai/ai_client"
require "monty_ai/file_handler"
require "monty_ai/syntax_highlighter"
require "monty_ai/ui"
require "monty_ai/formatter"

module MontyAI
  class Error < StandardError; end

  # Core configuration
  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration) if block_given?
    end
  end

  # Configuration class for global settings
  class Configuration
    attr_accessor :api_key, :api_endpoint

    def initialize
      @api_key = ENV["OPENAI_API_KEY"] || ENV["ANTHROPIC_API_KEY"]
      @api_endpoint = "https://api.openai.com/v1/chat/completions"
    end
  end
end
