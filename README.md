<div align="center">
  <img src="montyai-logo.svg" alt="MitchAI" width="500">
</div>

# MontyAI

## 🚀 Overview

MontyAI is an intelligent code explanation tool that uses AI to help you
understand code faster. Simply point MontyAI at a code file, and it will provide
a clear, concise explanation of what the code does.

## 🛠️ Installation

Add this line to your application's Gemfile:

```ruby
gem 'monty-ai'
```

And then execute:

```bash
bundle install
```

Or install it yourself as:

```bash
gem install monty-ai
```

## 💡 Usage

### Basic Usage

Explain a file:

```bash
monty explain path/to/file.rb
```

Pipe code to MontyAI:

```bash
cat path/to/file.rb | monty explain
```

### Example

```bash
monty explain lib/my_app/parser.rb
```

Output:

```
Explanation for lib/my_app/parser.rb:

This code defines a Parser class that processes text files into structured data.

The Parser class has three main methods:
- parse: Takes a file path, reads the content, and converts it to a structured format.
- process_line: Handles individual lines from the file, applying regex patterns.
- extract_data: Pulls out specific information based on the content type.

The code implements the Strategy pattern by dynamically selecting different
processing methods based on the file's content type.
```

### Check Version

```bash
monty version
```

## ⚙️ Configuration

MontyAI uses OpenAI or Anthropic APIs for code explanation. Set your API key in
an environment variable:

```bash
# For OpenAI (default)
export OPENAI_API_KEY=your_api_key_here

# For Anthropic
export ANTHROPIC_API_KEY=your_api_key_here
```

## 📋 Requirements

- Ruby 3.0+
- OpenAI API Key

## 🧪 Development

```bash
# Clone the repository
git clone https://github.com/scookdev/mitch_ai.git

# Install dependencies
bundle install

# Run tests
bundle exec rspec

# Run linter
bundle exec rubocop
```

To install this gem onto your local machine, run `bundle exec rake install`.

## 🗺️ Roadmap

Future versions will include:

- Syntax highlighting
- Multiple explanation formats (line-by-line, summary, concept)
- Interactive TTY interface
- Keyboard navigation

## 🤝 Contributing

Contributions are welcome! Please check out our [Contributing Guidelines](CONTRIBUTING.md).

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## 🙌 Acknowledgments

- Powered by OpenAI
- Inspired by the need for intelligent code reviews

## 💬 Support

If you encounter any problems or have suggestions, please [open an issue](https://github.com/scookdev/monty_ai/issues).
