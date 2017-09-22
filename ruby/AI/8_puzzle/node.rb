class Node
  attr_accessor :id, :board, :score, :parent_id, :chield_ids
  @@nodes = []
  @@leave_node_ids = []

  def initialize(board, parent_id = nil)
    @id = board.hash
    @board = board
    @score = board.score
    @parent_id = parent_id
    @chield_ids = []
    @@nodes << self
  end

  def add_chield(board)
    chield_ids << board.hash
    @@leave_node_ids << board.hash
    @@leave_node_ids.delete_if { |n| n == self.id}
    Node.new(board, self.id)
  end

  def parent
    @@nodes.find { |n| n.id == parent_id}
  end

  def children
    chield_ids.map { |chield_id| @@nodes.find { |n| n.id == chield_id } }
  end

  def self.nodes
    @@nodes
  end

  def self.leave_nodes
    @@leave_node_ids.map { |id| @@nodes.find { |n| n.id == id} }
  end
end
