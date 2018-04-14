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
  def parse(tokens)
    tokens = tokens.split_with_token_type(:NEWLINE)

    tree = []
    tokens.each do |line|
      unless (new_line = parse_methods(line)).nil?
        tree << new_line
      end
    end

    tree
  end

  private

  # Parse methods like puts
  def parse_methods(line)
    line.each do |token|
      next unless token[:type] == :IDENTIFIER

      return {
        identifier: token[:value].to_sym,
        value: parse_sub_methods(line - [token])
      }
    end
  end

  # Parse sub methods like to_string, to_integer
  def parse_sub_methods(line)
    new_line = []

    line.each do |token|
      next unless token[:type] == :IDENTIFIER


      value = [line[line.index(token) + 1]]
      line -= value
      line[line.index(token)] = {
        identifier: token[:value].to_sym,
        value: value
      }

      return line
    end
  end
end