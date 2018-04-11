class Token
  attr_reader :type, :content

  def initialize(options)
    @type = options[:type]
    @content = options[:content]
  end

  # newline identifier operator num string
end
