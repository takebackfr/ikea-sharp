require 'hue'

class Core

  # Methods
  # Print in the console
  def TÄRNÖ(content)
    puts eval(content.map { |token| token[:value] }.join)
  end

  COLORS = {
    ODGER: :white,
    FANBYN: :black,
    BERNHARD: :red,
    MARTIN: :green,
    TOBIAS: :yellow,
    FÖLJAREN: :blue,
    VOXNAN: :magenta,
    SALVIKEN: :cyan
  }

  COLORS.each do |name, value|
    define_method "TÄRNÖ_#{name}" do |content|
      puts eval(content.map { |token| token[:value] }.join).send(value) + "".white
    end
  end

  # Sub methods
  # Convert to string
  def BENÖ(content)
    # If the argument isn't an integer
    unless content[0][:type] == :NUMBER
      bad "TINGBY BOLMÅN PLATSA: #{content[0][:value]}"
      exit
    end

    {
      type: :STRING,
      value: "\"#{content[0][:value]}\""
    }
  end

  # Convert to integer
  def ISTAD(content)
    # If the argument isn't a string
    unless content[0][:type] == :STRING
      bad "TINGBY BOLMÅN INDUSTRIELL: #{content[0][:value]}"
      exit
    end

    {
      type: :NUMBER,
      value: content[0][:value].gsub('"', '').to_i
    }
  end

end