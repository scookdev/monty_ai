# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
RSpec.describe MontyAI do
  it "has a version number" do
    expect(MontyAI::VERSION).not_to be nil
  end

  describe ".configuration" do
    it "returns a Configuration instance" do
      expect(MontyAI.configuration).to be_a(MontyAI::Configuration)
    end

    it "returns the same instance when called multiple times" do
      config1 = MontyAI.configuration
      config2 = MontyAI.configuration
      expect(config1).to be(config2)
    end
  end

  describe ".configure" do
    it "yields the configuration to a block" do
      expect { |b| MontyAI.configure(&b) }.to yield_with_args(MontyAI.configuration)
    end

    it "allows setting configuration values" do
      original_api_key = MontyAI.configuration.api_key
      begin
        MontyAI.configure do |config|
          config.api_key = "test-api-key"
        end
        expect(MontyAI.configuration.api_key).to eq("test-api-key")
      ensure
        # Reset to original value
        MontyAI.configure do |config|
          config.api_key = original_api_key
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
