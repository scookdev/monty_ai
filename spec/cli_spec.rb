# frozen_string_literal: true

RSpec.describe MontyAI::CLI do
  let(:cli) { described_class.new }
  let(:test_code) { "puts 'Hello, World!'" }
  let(:test_file) { "spec/fixtures/test_code.rb" }
  let(:mock_explanation) { "This code prints 'Hello, World!' to the console." }

  before do
    # Create a test file
    FileUtils.mkdir_p(File.dirname(test_file))
    File.write(test_file, test_code)

    # Stub AI client
    allow_any_instance_of(MontyAI::AIClient).to receive(:explain_code).and_return(mock_explanation)
  end

  after do
    FileUtils.rm_f(test_file)
  end

  describe "#explain" do
    it "reads a file and explains the code" do
      expect { cli.explain(test_file) }.to output(/#{mock_explanation}/).to_stdout
    end

    it "handles errors when file doesn't exist" do
      expect do
        cli.explain("non_existent_file.rb")
      end.to output(/Error: Failed to read file: File not found: non_existent_file.rb/).to_stdout.and raise_error(SystemExit)
    end

    it "explains code from stdin when no file is provided and stdin is not a tty" do
      # Simulate piping code to the command
      allow($stdin).to receive(:tty?).and_return(false)
      allow($stdin).to receive(:read).and_return(test_code)

      expect { cli.explain }.to output(/#{mock_explanation}/).to_stdout
    end

    it "shows an error message when no file is provided and stdin is a tty" do
      # Simulate running the command without piping or a file argument
      allow($stdin).to receive(:tty?).and_return(true)

      expect { cli.explain }.to output(/Error: Please provide a file/).to_stdout.and raise_error(SystemExit)
    end
  end

  describe "#version" do
    it "outputs the gem version" do
      expect { cli.send(:version) }.to output(/MontyAI version #{MontyAI::VERSION}/o).to_stdout
    end
  end
end
