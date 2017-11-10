class BotMemory 

  attr_reader :frontier, :path
  attr_accessor :seen_cells, :visited_cells, :walls

  def initialize(frontier=nil)
    @seen_cells = Hash.new(0) 
    @visited_cells = Hash.new(0)
    @walls = Hash.new(1) 
    @frontier = frontier || Stack.new
    @path = [] 
  end

  def set_frontier_strategy(strategy)
    if strategy == 'bfs'
      @frontier = Queue.new
    end
  end

  def seen_all_neighbors?(cell) 
    neighbors = []
    Grid::ALLOWED_MOVES.each do |move| 
      neighb = cell + move 
      if not @seen_cells.include? neighb and not @walls.include? neighb
        return false 
      end
    end
    return true
  end

  ##
  # Increment the related seen_cells hash value, 
  # add walls to memory.
  # Return the newly seen cells among the neighbors.
  #
  def save_seen(neighbors, walls) 
    neighbors.each do |neighbor| 
      @seen_cells[neighbor] += 1
    end
    walls.each do |wall| 
      @walls[wall] = 1
    end
    first_seen(neighbors) 
  end

  ##
  # Check if there are some newly seen 
  # cells in my neighbors.
  #
  def first_seen(neighbors) 
    f_s = []
    neighbors.each do |neighbor| 
      if @seen_cells[neighbor] == 1
        f_s.push(neighbor) 
        frontier.push(neighbor) 
      end
    end
    f_s
  end

  def get_last_seen_cell
    return nil if frontier.empty? 
    while true 
      position = frontier.pop
      if frontier.empty? 
        unless (seen_all_neighbors?(position) || visited_cells.include?(position) ) 
          return position 
        else 
          return nil
        end
      end

      unless (seen_all_neighbors?(position) || visited_cells.include?(position) ) 
        break
      end
    end
    position
  end

  def construct_grid
    Grid.new(@seen_cells, @walls) 
  end
end

