class IkeaString
  def to_integer(token)
    # Throw exception if the argument isn't a string
    unless token[0][:type] == :STRING
      bad "TINGBY BOLMÅN INDUSTRIELL: #{token[0][:value]}"
      exit
    end

    # Retrieves the token converted as number
    {
      type: :NUMBER,
      value: token[0][:value].gsub('"', '').to_i
    }
  end
end