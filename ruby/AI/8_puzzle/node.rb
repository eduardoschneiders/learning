class Node
  attr_accessor :id, :board, :move, :visited, :parent_id, :chield_ids
  @@nodes = []
  @@leave_node_ids = []

  def initialize(board,  move = nil, parent_id = nil)
    @id = board.hash
    @board = board
    @move = move
    @visited = false
    @parent_id = parent_id
    @chield_ids = []
    @@nodes << self
    @@leave_node_ids << @id
    delete_parent_on_leaves
  end

  def mark_as_visited
    @visited = true
  end

  def add_chield(board, move)
    return if node_already_exist?(board.hash)

    chield_ids << board.hash
    Node.new(board, move, self.id)
  end

  def node_already_exist?(id)
    Node.nodes.map(&:id).include? id
  end

  def delete_parent_on_leaves
    @@leave_node_ids.delete_if { |n| n == parent_id }
  end

  def parent
    @@nodes.find { |n| n.id == parent_id}
  end

  def count_moves
    count = 0

    current_node = parent

    begin
      count += 1
      current_node = current_node.parent
    end while current_node.parent_id != nil

    count
  end

  def children
    chield_ids.map { |chield_id| @@nodes.find { |n| n.id == chield_id } }
  end

  def self.nodes
    @@nodes
  end

  def self.leave_nodes
    @@leave_node_ids.map { |id| @@nodes.find { |n| n.id == id} }.select { |n| !n.visited }
  end

  def self.best_leave
    leave_nodes.select { |n| !n.visited }.min_by { |node| node.board.score }
  end
end
