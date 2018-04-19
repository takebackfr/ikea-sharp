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

  def write(tokens)
    unless tokens.size == 2
      bad "INDUSTRIELL RUNNEN: FYRESDAL:2"
      exit
    end

    unless tokens[0][:type] == :STRING && tokens[1][:type] == :STRING
      bad "TINGBY BOLMÅN INDUSTRIELL: #{tokens[0][:value]}"
      exit
    end

    begin
      File.write(
        file_name = tokens[0][:value].gsub('"', ''),
        tokens[1][:value].gsub('"', '')
      )
    rescue Errno::ENOENT
      bad "KALLARP VOXTORP EKESTAD: #{file_name}"
    end
  end
end