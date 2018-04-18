class IkeaFile
  def read(token)
    unless token[0][:type] == :STRING
      bad "TINGBY BOLMÅN INDUSTRIELL: #{token[0][:value]}"
      exit
    end

    # Retrieves the token converted as string
    {
      type: :STRING,
      value: "\"#{File.read(token[0][:value].gsub('"', ''))}\""
    }
  end
end