# frozen_string_literal: true

RSpec.describe MontyAI::Formatter do
  describe ".format" do
    it "returns the input explanation unchanged" do
      explanation = "This code defines a class that does something."
      expect(described_class.format(explanation)).to eq(explanation)
    end
  end
end
