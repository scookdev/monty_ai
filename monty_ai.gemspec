# frozen_string_literal: true

require_relative "lib/monty_ai/version"

Gem::Specification.new do |spec|
  spec.name = "monty-ai"
  spec.version = MontyAI::VERSION
  spec.authors = ["Steve Cook"]
  spec.email = ["stevenbradleycook@gmail.com"]

  spec.summary = "CLI tool to explain code using AI"
  spec.description = "MontyAI is an intelligent code explanation tool that uses AI to help you understand code faster."
  spec.homepage = "https://github.com/scookdev/monty_ai"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.4.2"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  spec.files = Dir.glob("{bin,lib}/**/*") + %w[LICENSE README.md]
  spec.bindir = "bin"
  spec.executables = ["monty"]
  spec.require_paths = ["lib"]

  # Dependencies
  spec.add_dependency "thor", "~> 1.2"

  # Development dependencies
  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "standard", "~> 1.3"
end
