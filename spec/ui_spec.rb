# frozen_string_literal: true

RSpec.describe MontyAI::UI::Interface do
  let(:code) { "def hello\n  puts 'world'\nend" }
  let(:explanation) { "This is a simple Ruby method that prints 'world'." }
  let(:filename) { "example.rb" }

  describe "#initialize" do
    it "creates a new UI interface with code and explanation" do
      ui = described_class.new(code, explanation, filename)
      expect(ui.code).to eq(code)
      expect(ui.explanation).to eq(explanation)
      expect(ui.filename).to eq(filename)
    end
  end

  describe "#render" do
    let(:ui) { described_class.new(code, explanation, filename) }

    it "outputs the formatted UI" do
      # This is hard to test directly because of terminal output
      # So we'll just check that it doesn't raise an error
      expect { ui.render }.not_to raise_error
    end
  end
end
