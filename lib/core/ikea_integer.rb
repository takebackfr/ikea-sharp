class IkeaInteger
  def to_string(token)
    # Throw exception if the argument isn't a number
    unless token[0][:type] == :NUMBER
      bad "TINGBY BOLMÅN PLATSA: #{token[0][:value]}"
      exit
    end

    # Retrieves the token converted as string
    {
      type: :STRING,
      value: "\"#{token[0][:value]}\""
    }
  end
end