class IkeaCore
  # Print a string in the console
  def print(tokens)
    query = tokens.map { |token| token[:value] }.join
    puts eval(query)
  end
end