require_relative 'core'
require 'hue'

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

    begin
      Core.new.send(method_name, arguments)
    rescue NoMethodError
      bad "SÖTVEDEL RODD MYSKGRÄS: #{method_name}"
      exit
    rescue SyntaxError
      bad "MULIG VÄXER: #{method_name}"
      exit
    end
  end
end