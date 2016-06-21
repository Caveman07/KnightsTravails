
require "Set"


class Node
    attr_accessor :parent, :children, :value
    #should have as many nodes insides as it possible. Max possible moves can be 8. 

  def initialize(value, parent=nil)
      @value = value
      @children = []
      @parent = parent
      
  end

  def add_child(child_node)
  		#should create new @nextmove every time insert is called on the node
      child_node.parent && child_node.parent.remove_child(child_node)
      @children << child_node
      child_node.parent = self
      child_node
  end

  def remove_child(child_node)
  	@children.delete(child_node)
  	child_node.parent = nil
  	nil
  end

  def bfs(value)
  	  queue = [self]
  	  until queue.empty?
  	  	current_node = queue.shift 
  	  	return current_node if current_node.value == value
  	  	queue += current_node.children
  	 end
  	 nil
  end

  def path
  	if self.parent == nil
  		return [self.value]
  	else 
  		self.parent.path << self.value
  	end
  end

end


class KnightTravel

	attr_accessor :root, :board 

	def initialize
		@board = board
		@root = nil
		
	 	#this method takes @root and @board and builds the move tree. The problem comes because we assign start pos in other method
		#we build @board with a method which creates an array and stores all possible Nodes on a board. 
	end

	def knight_moves(start_pos, destination)

		if valid?(start_pos) && valid?(destination)
			@root = find_start(start_pos)
			build_move_tree(start_pos)
			# puts @root.bfs(destination).path.join(",")
			find_path(destination)
			
		end
	end


	def find_start(start_pos)
		root = nil
		@board.each do |root_node|
			if root_node.value == start_pos
				root = root_node
			end
		end
		root
	end

	def board

		board = []
		i,j = 1, 1
		for i in (1..8)
		      for j in (1..8)
		      	board << Node.new([i,j])
		      	j += 1
		      end
		  i += 1
		end
		board  
		#creates array of all possible moves
	end 

	def build_move_tree(pos)
		#this method uses add.child to populate all nodes with children
		queue =[@root]
		visited_squares = Set.new [@root]

		    until queue.empty? 
		        current_square = queue.shift
			    valid_squares = possible_moves(current_square.value)
		        valid_squares.each do |square|
		        	unless visited_squares.include?(square)
		        		queue << square
		        		visited_squares << square
		        		current_square.add_child(square)
		        	end
		        end
		    end
		    nil
	end

	def possible_moves(pos)
		#returns an array of nodes that are possible from a given position
		x,y = pos

		valid_moves = []

		moves = [[x+1, y+2],[x+1,y-2],
		[x-1,y+2],[x-1,y-2], 
		[x+2,y-1], [x+2,y+1], 
		[x-2,y+1], [x-2, y-1]]

		@board.each do |square|
			moves.each do |position|
			    if square.value == position
			    	valid_moves << square
			    end
			end
		end
		valid_moves
		#gives correct nodes
	end

	def find_path(target_value)
		puts "Your moves are:"
		puts @root.bfs(target_value).path.inspect
		
	end


    def valid?(position)
    	if position.any? {|number| !number.between?(1,8) } || position.length != 2
    		puts "Your input must be within 1 and 8"
    		return false
    	else return true
    	end
	end
end

test = KnightTravel.new
test.knight_moves([2,2],[8,7])


