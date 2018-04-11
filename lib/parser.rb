require_relative 'lexer'

# Monkey patching for Array#split_with_token_type
class Array

  # Split the array with a specific token type
  def split_with_token_type(type)
    inject([[]]) do |results, element|
      if element[:type] == type
        results << []
      else
        results.last << element
      end

      results
    end
  end

end

class Parser
  def parse(code)
    tokens = Lexer.new.tokenize(code).split_with_token_type(:NEWLINE)

    tree = []
    tokens.each do |line|
      # Get all identifiers names
      identifiers_names = line.select { |token| token[:type] == :IDENTIFIER }
      # Get the identifier's arguments
      arguments = line.split_with_token_type(:IDENTIFIER)[1..-1]

      # Combine identifiers and arguments in a same structure
      line_tree = []
      identifiers_names.size.times do |i|
        line_tree << {
          identifier: identifiers_names[i],
          value: arguments[i]
        }
      end

      # Add the line's tree to the global tree
      tree << line_tree
    end

    tree
  end
end