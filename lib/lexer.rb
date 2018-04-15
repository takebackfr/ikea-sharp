class Lexer
  def tokenize(code)
    # Cleanup code by remove extra line breaks
    code.chomp!

    # Current character position we're parsing
    i = 0

    # Collection of all parsed tokens in the form {type: type, value: value}
    tokens = []

    while i < code.size
      chunk = code[i..-1]

      if string = chunk[/\ABEHÅLLARE(.*?)BEHÅLLARE/]
        tokens << { type: :STRING, value: string.gsub('BEHÅLLARE', '"') }

        i += string.size
      # Matching basic tokens like keywords, var names, methods
      elsif identifier = chunk[/\A[A-ZÄÖÅ_]+/]
        tokens << { type: :IDENTIFIER, value: identifier }

        i += identifier.size
      elsif number = chunk[/\A([0-9]+)/]
        tokens << { type: :NUMBER, value: number.to_i }

        i += number.size
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