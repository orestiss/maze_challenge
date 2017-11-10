class GridBuilder 

  FREE = '-'
  BOT = 'b'
  WALL = '#'
  GOAL = '@'

  def get_grid_from_file(file_path) 
    parse_file(file_path) 
    grid = Grid.new(@free_cells, @walls) 
    if defined? @bot_position 
      grid.set_bot_position(@bot_position) 
    end
    if defined? @goal_position 
      grid.set_goal_position(@goal_position) 
    end
    grid
  end

  def get_grid_from_data(free_cells, walls) 
    Grid.new(free_cells, walls) 
  end

  def parse_file(file_path) 

    @free_cells = Hash.new
    @walls = Hash.new

    File.foreach(file_path).with_index do |line, row| 
      line.gsub("\n", '').split('').each_with_index do |char, col|
        position_vector = Vector[row, col] 

        case char 

        when FREE 
          @free_cells[position_vector] = 1
        when BOT
          @bot_position = position_vector
          @free_cells[position_vector] = 1
        when GOAL
          @goal_position = position_vector
          @free_cells[position_vector] = 1
        when WALL 
          @walls[position_vector] = 1
        else 
          raise InvalidFileError.new(file_path) 
        end

      end
    end
  end
end
