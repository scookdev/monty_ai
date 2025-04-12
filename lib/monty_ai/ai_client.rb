# frozen_string_literal: true

require "net/http"
require "uri"
require "json"

module MontyAI
  class AIClient
    def initialize(api_key: nil)
      @api_key = api_key || MontyAI.configuration.api_key
      @endpoint = MontyAI.configuration.api_endpoint

      return unless @api_key.nil? || @api_key.empty?

      raise Error, "API key is required. Set OPENAI_API_KEY or ANTHROPIC_API_KEY environment variable."
    end

    def explain_code(code)
      prompt = build_prompt(code)
      response = send_request(prompt)
      parse_response(response)
    end

    private

    def build_prompt(code)
      "Please explain the following code clearly and concisely:\n\n#{code}\n\n" \
      "Provide a general overview of what it does followed by explanations of important parts. " \
      "Include details about any non-obvious logic, design patterns, or potential issues."
    end

    def send_request(prompt)
      uri = URI.parse(@endpoint)
      request = Net::HTTP::Post.new(uri)
      request["Content-Type"] = "application/json"
      request["Authorization"] = "Bearer #{@api_key}"

      # Adjust parameters based on API being used
      if @endpoint.include?("openai")
        body = {
          model: "gpt-4",
          messages: [
            { role: "system",
              content: "You are a helpful code explanation assistant that explains code clearly and concisely." },
            { role: "user", content: prompt }
          ],
          temperature: 0.3
        }
      elsif @endpoint.include?("anthropic")
        # Update endpoint if using Anthropic
        @endpoint = "https://api.anthropic.com/v1/messages"
        body = {
          model: "claude-3-opus-20240229",
          messages: [
            { role: "user", content: prompt }
          ],
          temperature: 0.3
        }
      end

      request.body = body.to_json

      response = nil
      begin
        response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
          http.request(request)
        end
      rescue StandardError => e
        raise Error, "API request failed: #{e.message}"
      end

      raise Error, "API request failed: #{response.code} #{response.message}" unless response.is_a?(Net::HTTPSuccess)

      JSON.parse(response.body)
    end

    def parse_response(response)
      if response["choices"]
        # OpenAI format
        response["choices"][0]["message"]["content"]
      elsif response["content"]
        # Anthropic format
        response["content"][0]["text"]
      else
        raise "Unexpected API response format"
      end
    rescue StandardError => e
      raise Error, "Failed to parse API response: #{e.message}"
    end
  end
end
