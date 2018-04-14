require_relative 'core'

class Runtime
  def run(tree)
    tree.each do |line|
      value = line[:value]

      value.each do |token|
        unless token[:identifier].nil?
          # Execute an replace the sub method
          value[value.index(token)] = exec_method(token)
        end
      end

      # Execute the line method with executed sub methods
      exec_method({
        identifier: line[:identifier],
        value: value
                  })
    end
  end

  private

  # Execute a method defined by { identifier: value, value: arguments } structure
  def exec_method(token)
    method_name = token[:identifier]
    arguments = token[:value]

    Core.new.send(method_name, parse_arguments(arguments))
  end

  # Parse an array of tokens into an array of values
  def parse_arguments(arguments)
    arguments.map { |arg| arg[:value] }
  end
end