require_relative 'lexer'
require_relative 'parser'
require_relative 'runtime'

raise 'You must enter the file name' unless ARGV.size == 1

tokens = Lexer.new.tokenize(File.read(ARGV[0]))
tree = Parser.new.parse(tokens)
Runtime.new.run(tree)