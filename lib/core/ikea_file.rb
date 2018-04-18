class IkeaFile
  def read(token)
    unless token[0][:type] == :STRING
      bad "TINGBY BOLMÅN INDUSTRIELL: #{token[0][:value]}"
      exit
    end

    begin
      content = File.read(file_name = token[0][:value].gsub('"', ''))
    rescue Errno::ENOENT
      bad "KALLARP VOXTORP EKESTAD: #{file_name}"
    end

    # Retrieves the token converted as string
    {
      type: :STRING,
      value: "\"#{content}\""
    }
  end
end