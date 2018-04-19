require_relative 'core/ikea_core'
require_relative 'core/ikea_integer'
require_relative 'core/ikea_string'
require_relative 'core/ikea_file'
require 'hue'

METHODS = [
  { class: 'IkeaCore', ikea_name: :TÄRNÖ, name: :print }
].freeze

SUBMETHODS = [
  { class: 'IkeaInteger', ikea_name: :BENÖ, name: :to_string, arguments: 1 },
  { class: 'IkeaString', ikea_name: :ISTAD, name: :to_integer, arguments: 1 },
  { class: 'IkeaFile', ikea_name: :KAFFEREP, name: :read, arguments: 1 }
].freeze

class Runtime

  def run(tree)
    tree.each do |line|
      value = line[:value]

      value.each do |token|
        unless token[:identifier].nil?
          # Execute and replace the sub method
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

    if METHODS.any? { |method| method[:ikea_name] == method_name }
      METHODS.each do |method|
        next unless method[:ikea_name] == method_name

        eval "#{method[:class]}.new.#{method[:name]}(#{arguments})"
      end
    elsif SUBMETHODS.any? { |submethod| submethod[:ikea_name] == method_name }
      SUBMETHODS.each do |submethod|
        next unless submethod[:ikea_name] == method_name

        unless arguments.size == submethod[:arguments]
          bad "INDUSTRIELL RUNNEN: #{method_name}:#{submethod[:arguments]}"
          exit
        end

        return eval "#{submethod[:class]}.new.#{submethod[:name]}(#{arguments})"
      end
    else
      bad "SÖTVEDEL RODD MYSKGRÄS: #{method_name}"
      exit
    end
  end
end