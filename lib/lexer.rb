require_relative 'token'

class Lexer
  def initialize(source_code)
    @source_code = source_code
  end

  def tokenize
    # Collection of all the parsed tokens
    tokens = []

    # Current character postion
    i = 0

    while i < @source_code.size
      chunk = @source_code[i..-1]

      if chunk[/\A /]
        i += 1
      elsif operator = chunk[/\A[+*=\-\/]/]
        tokens << Token.new(type: :operator, content: operator)

        i += 1
      elsif literal = chunk[/\A\.[^.]*\./]
        tokens << Token.new(type: :literal, content: literal.delete('.'))

        i += literal.size
      elsif num = chunk[/\A[0-9]+/]
        tokens << Token.new(type: :num, content: num.to_i)

        i += num.size
      elsif identifier = chunk[/\A[A-ZÄÖ]*/]
        tokens << Token.new(type: :identifier, content: identifier)

        i += identifier.size
      end
    end

    tokens
  end
end