# frozen_string_literal: true

require_relative "lib/monty_ai/version"

Gem::Specification.new do |spec|
  spec.name = "monty-ai"
  spec.version = MontyAI::VERSION
  spec.authors = ["Steve Cook"]
  spec.email = ["stevorevo@duck.com"]

  spec.summary = "CLI tool to explain code using AI"
  spec.description = "MontyAI is an intelligent code explanation tool that uses AI to help you understand code faster."
  spec.homepage = "https://github.com/scookdev/monty_ai"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.4.2"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = "exe"
  spec.executables = ["monty-ai"]
  spec.require_paths = ["lib"]

  # Dependencies
  spec.add_dependency "pastel", "~> 0.8.0" # For terminal colors
  spec.add_dependency "rouge", "~> 4.0" # For syntax highlighting
  spec.add_dependency "thor", "~> 1.2"
  spec.add_dependency "tty-box", "~> 0.7.0"
  spec.add_dependency "tty-pager", "~> 0.14.0"
  spec.add_dependency "tty-screen", "~> 0.8.1"
  spec.add_dependency "tty-spinner", "~> 0.9.3"

  # Development dependencies
  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "standard", "~> 1.3"
end
