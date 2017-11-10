class Grid 

  ALLOWED_MOVES = [Vector[1, 0], Vector[-1, 0], Vector[0, 1], Vector[0, -1]]

  attr_reader :bot_position, :free_cells

  def initialize(free_cells, walls) 
    @free_cells = free_cells 
    @walls = walls 
  end

  def set_bot_position(bot_position)
    @bot_position = bot_position
  end

  def set_goal_position(goal_position) 
    @goal_position = goal_position
  end

  def get_neighbors(position, with_walls=false) 
    raise OutOfBoundsError.new if ! in_bounds? position 
    free_neighbors = [] 
    walls = []

    ALLOWED_MOVES.each do |move| 
      vector = position + move 
      if @free_cells.include? vector 
        free_neighbors.push(vector) 
      elsif @walls.include? vector 
        walls.push(vector) 
      end
    end
    return free_neighbors, walls if with_walls
    return free_neighbors
  end

  def in_bounds?(position) 
    @free_cells.include?(position) || @walls.include?(position)
  end

  def is_goal?(position) 
    position == @goal_position
  end

  def self.manhattan(start, finish) 
    diff = start - finish 
    diff[0].abs + diff[1].abs
  end
end
