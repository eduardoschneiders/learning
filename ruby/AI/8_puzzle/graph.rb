graph = Graph.new
graph.create_graph(root_node)

class Graph
  attr_accessor :graph

  def initialize
    @graph = GraphViz.new( :G, :type => :digraph )
    generate_graph.call(g, root_node)
  end

  def create_graph(node)
    node_id = node.move.to_s + node.hash.to_s[0..5]
    options = { label: node.move.to_s + ' ' + node.table.score.to_s }
    options.merge!(style: 'filled') if node.finished

    rn = g.add_node(node_id, options)

    node.nodes.each do |node|
      ch = generate_graph.call(g, node)
      g.add_edges(rn, ch)
    end

    rn
  end

  def output
    @graph.output(jpg: "graph.jpg")
  end
end
