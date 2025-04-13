# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
RSpec.describe MontyAI::FileHandler do
  let(:test_file_path) { "spec/fixtures/test_code.rb" }
  let(:test_file_content) { "puts 'Hello, World!'" }

  before do
    # Create a test directory and file
    FileUtils.mkdir_p(File.dirname(test_file_path))
    File.write(test_file_path, test_file_content)
  end

  after do
    # Clean up the test file
    FileUtils.rm_f(test_file_path)
  end

  describe ".read" do
    it "reads the content of a file" do
      expect(described_class.read(test_file_path)).to eq(test_file_content)
    end

    it "raises an error when the file doesn't exist" do
      expect do
        described_class.read("non_existent_file.rb")
      end.to raise_error(MontyAI::Error, /File not found/)
    end

    context "when file is not readable" do
      before do
        # Make the file unreadable on Unix-like systems
        # This test will be skipped on Windows
        if Gem.win_platform?
          skip "Cannot test file permissions on Windows"
        else
          FileUtils.chmod(0o000, test_file_path)
        end
      end

      after do
        # Make the file readable again for cleanup
        FileUtils.chmod(0o644, test_file_path) unless Gem.win_platform?
      end

      it "raises an error when the file is not readable" do
        expect do
          described_class.read(test_file_path)
        end.to raise_error(MontyAI::Error, /Cannot read file/)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
