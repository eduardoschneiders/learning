class Node
  attr_accessor :id, :board, :move, :visited, :parent_id, :chield_ids
  @@nodes = []
  @@leave_nodes = []

  def initialize(board,  move = nil, parent_id = nil)
    @id = board.hash
    @board = board
    @move = move
    @visited = false
    @parent_id = parent_id
    @chield_ids = []
    @@nodes << self
    @@leave_nodes << self
  end

  # def mark_as_visited
  #   @visited = true
  # end

  def add_children(children_options)
    delete_on_leaves
    children_options.each do |options|
      next if node_already_exist?(options[:board].hash)

      chield_ids << options[:board].hash
      Node.new(options[:board], options[:move], self.id)
    end
  end

  def node_already_exist?(id)
    Node.nodes.map(&:id).include? id
  end

  def delete_on_leaves
    @@leave_nodes.delete_if { |n| n && n.id == self.id }
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
    @@leave_nodes
  end

  def self.best_leave
    leave_nodes.compact.select { |n| !n.visited }.min_by { |node| node.board.score }
  end
end
