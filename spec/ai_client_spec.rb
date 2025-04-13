# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
RSpec.describe MontyAI::AIClient do
  let(:api_key) { "test-api-key" }
  let(:test_code) { "puts 'Hello, World!'" }
  let(:mock_response) { "This code prints 'Hello, World!' to the console." }

  before do
    # Set up configuration
    allow(MontyAI).to receive_message_chain(:configuration, :api_key).and_return(api_key)
    allow(MontyAI).to receive_message_chain(:configuration, :api_endpoint).and_return("https://api.openai.com/v1/chat/completions")
  end

  describe "#initialize" do
    it "uses the API key from configuration when not provided" do
      client = described_class.new
      # We can't directly test the private @api_key, but we can test that it works
      # by checking that the send_request method is called with the right arguments

      # Stub the send_request and parse_response methods
      allow(client).to receive(:send_request).and_return({})
      allow(client).to receive(:parse_response).and_return(mock_response)

      expect(client).to receive(:send_request).with(anything)
      client.explain_code(test_code)
    end

    it "raises an error when API key is not provided and not in configuration" do
      allow(MontyAI).to receive_message_chain(:configuration, :api_key).and_return(nil)

      expect do
        described_class.new
      end.to raise_error(MontyAI::Error, /API key is required/)
    end
  end

  describe "#explain_code" do
    let(:client) { described_class.new(api_key: api_key) }

    before do
      # Stub HTTP request
      http_response = double("HTTPResponse", body: JSON.generate({
        "choices" => [
          {
            "message" => {
              "content" => mock_response
            }
          }
        ]
      }))
      allow(http_response).to receive(:is_a?).with(Net::HTTPSuccess).and_return(true)

      # Stub Net::HTTP
      allow_any_instance_of(Net::HTTP).to receive(:request).and_return(http_response)
    end

    it "returns an explanation for the given code" do
      expect(client.explain_code(test_code)).to eq(mock_response)
    end

    it "builds a prompt for the code" do
      # We're testing that build_prompt is called with the right argument
      # and that its result is passed to send_request
      expect(client).to receive(:build_prompt).with(test_code).and_call_original
      expect(client).to receive(:send_request).and_call_original

      client.explain_code(test_code)
    end
  end
end
# rubocop:enable Metrics/BlockLength
