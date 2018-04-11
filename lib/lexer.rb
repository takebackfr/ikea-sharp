class Lexer
  # All language's keywords
  KEYWORDS = %w(
    HENRIKSDAL INGATROP
  )

  def tokenize(code)
    # Cleanup code by remove extra line breaks
    code.chomp!

    # Current character position we're parsing
    i = 0

    # Collection of all parsed tokens in the form {type: type, value: value}
    tokens = []

    while i < code.size
      chunk = code[i..-1]

      # Matching basic tokens like keywords, var names, methods
      if identifier = chunk[/\A[A-ZÄÖ_]+/]
        # Keywords are special identifiers which are tagged with their own name
        if KEYWORDS.include? identifier
          tokens << { type: identifier.upcase.to_sym, value: identifier }
        else
        # Non keywords include var names or methods
          tokens << { type: :IDENTIFIER, value: identifier }
        end

        i += identifier.size
      elsif number = chunk[/\A([0-9]+)/]
        tokens << { type: :NUMBER, value: number.to_i }

        i += number.size
      elsif string = chunk[/\A"(.*?)"/]
        tokens << { type: :STRING, value: string }

        i += string.size
      elsif operator = chunk[/\A[(\+|-|\*|\/]/]
        tokens << { type: :OPERATOR, value: operator }

        i += 1
      elsif chunk.match(/\A /)
        i += 1
      elsif newline = chunk[/\A\n/]
        tokens << { type: :NEWLINE, value: newline }

        i += 1
      else
        value = chunk[0]
        tokens << { type: value.upcase.to_sym, value: value }
        i += 1
      end
    end

    tokens
  end
end