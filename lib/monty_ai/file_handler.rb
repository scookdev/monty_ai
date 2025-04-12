# frozen_string_literal: true

module MontyAI
  # Class FileHandler opens files for explanations
  class FileHandler
    def self.read(path)
      raise Error, "File not found: #{path}" unless File.exist?(path)

      raise Error, "Cannot read file: #{path}" unless File.readable?(path)

      File.read(path)
    rescue StandardError => e
      raise Error, "Failed to read file: #{e.message}"
    end
  end
end
