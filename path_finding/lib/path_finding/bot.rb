class Bot 

  attr_reader :grid, :memory 
  attr_accessor :prev_position, :position, :result 

  def initialize(grid, position, retreat_algorithm = nil, frontier=nil) 
    @result = nil 
    @grid = grid 
    @position = position
    @memory = BotMemory.new(frontier)
    set_position(position)
    @retreat = [] 
    @retreat_algorithm = retreat_algorithm || AStar.new
  end

  def set_memory_strategy(strategy)
    memory.set_frontier_strategy(strategy) 
  end

  def set_position(position) 
    raise OutOfBoundsError.new if !grid.in_bounds? position 
    raise ArgumentError.new("position not within reach") if (!within_reach? position) 
    @prev_position = @position
    @position = position 
    memory.seen_cells[@position] += 1
    memory.visited_cells[@position] += 1
    @memory.path.push(position)
  end

  def within_reach?(position) 
    Grid.manhattan(@position, position) <= 1
  end

  ##
  # Bot stops moving when the result is either 
  # found, or fail after it has searched all 
  # free cells.
  #
  def move 
    while true 
      choose_next_position 
      if [:found, :fail].include? @result
        break 
      end
    end
  end

  def choose_next_position
    if not @retreat.empty? 
      set_position(@retreat.shift) 
      return 
    end
    free_neighbs, walls  = grid.get_neighbors(@position, with_walls=true) 
    if found_goal? free_neighbs
      @result = :found 
      return 
    end

    first_seen = memory.save_seen(free_neighbs, walls) 

    if first_seen.size > 0 
      choose_from_newly_seen(first_seen) 
    else
      if !design_retreat
        @result = :fail
      end
    end
  end

  def choose_from_newly_seen(first_seen) 
    # keep the same direction if available
    if first_seen.include? @position + orientation 
      set_position(@position + orientation)
    else 
      set_position( first_seen[0] )
    end
  end

  ##
  # Get the direction of the previous move.
  #
  def orientation 
    @position - @prev_position
  end

  ##
  # Checks if one of the provided vectors 
  # contains the goal.
  #
  def found_goal?(neighbors) 
    neighbors.each do |neighb| 
      if grid.is_goal? neighb
        set_position(neighb) 
        return true
      end
    end
    return false
  end

  def design_retreat
    last_seen = memory.get_last_seen_cell
    if last_seen.nil? 
      return false 
    end
    @retreat = get_path(@position, last_seen)  
    @retreat.shift
  end

  ##
  # Redefine the graph-memory upon which the algorithm will run,
  # and return the optimal path between the start and finish cells.
  #
  def get_path(start, finish) 
    @retreat_algorithm.set_graph(memory.construct_grid) 
    @retreat_algorithm.run(start, finish)
  end

  def path
    memory.path
  end

  def total_moves
    memory.visited_cells.values.sum
  end
end
