require 'graphviz'
# graph = Graph.new
# graph.create_graph(root_node)

class Graph
  attr_accessor :graph

  def initialize
    @graph = GraphViz.new( :G, :type => :digraph )
    # generate_graph.call(g, root_node)
  end

  def build_graph(node)
    node_id = node.move.to_s + node.id.to_s[0..5]
    options = { label: node.move.to_s + ' ' + node.board.score.to_s }
    # options.merge!(style: 'filled') if node.finished

    current_node = graph.add_node(node_id, options)

    node.children.each do |node|
      child = build_graph(node)
      graph.add_edges(current_node, child)
    end

    current_node
  end

  def output
    graph.output(jpg: "graph.jpg")
  end
end
