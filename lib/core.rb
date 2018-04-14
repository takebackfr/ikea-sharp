class Core

  # Methods
  # Print in the console
  def TÄRNÖ(content)
    puts eval(content.join)
  end

  # Sub methods
  # Convert to string
  def BENÖ(content)
    {
      type: :STRING,
      value: "\"#{content[0]}\""
    }
  end

  # Convert to integer
  def ISTAD(content)
    {
      type: :NUMBER,
      value: content[0].gsub('"', '').to_i
    }
  end

end