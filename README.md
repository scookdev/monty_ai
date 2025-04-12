<div align="center">
  <img src="montyai-logo.svg" alt="MitchAI" width="500">
</div>

# MontyAI

MontyAI is an intelligent code explanation tool that uses AI to help you understand code faster. Simply point MontyAI at a code file, and it will provide a clear, concise explanation of what the code does.

## Installation

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

## Usage

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

## Configuration

MontyAI uses OpenAI or Anthropic APIs for code explanation. Set your API key in an environment variable:

```bash
# For OpenAI (default)
export OPENAI_API_KEY=your_api_key_here

# For Anthropic
export ANTHROPIC_API_KEY=your_api_key_here
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Roadmap

Future versions will include:

- Syntax highlighting
- Multiple explanation formats (line-by-line, summary, concept)
- Interactive TTY interface
- Keyboard navigation

## Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/scookdev/monty_ai>.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
