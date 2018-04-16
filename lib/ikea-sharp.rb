require_relative 'lexer'
require_relative 'parser'
require_relative 'runtime'
require 'hue'

info 'Welcome in Ikea#'
que 'Enter the file name:'
code = File.read(gets.chomp)
run 'Ikea# interpreter working...'
tokens = Lexer.new.tokenize(code)
tree = Parser.new.parse(tokens)
Runtime.new.run(tree)