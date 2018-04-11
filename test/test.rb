require_relative '../lib/parser'
require_relative '../lib/lexer'

nodes=Nodes.new([ DefNode.new("method", ["a", "b"],
                              Nodes.new([TrueNode.new])
)
                ])
assert_equal nodes, Parser.new.parse(File.read('test.ikea'))