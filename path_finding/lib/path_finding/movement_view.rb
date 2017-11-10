class MovementView 

  BOT = 'b'
  EMPTY_CELL = '-'
  GOAL = '@'

  def initialize(grid_file_path, bot_movement) 
    parse_file(grid_file_path) 
    @bot_movement = bot_movement
  end

  def parse_file(grid_file_path) 
    @map = [] 
    File.foreach(grid_file_path).with_index do |line, row| 
      @map.push( line.gsub("\n", '') )
    end
  end

  def display_incrementing_bot(time_to_sleep=0.3) 
    system "clear"
    while @bot_movement.size > 0 
      position = @bot_movement.shift 
      if [EMPTY_CELL, GOAL].include? @map[position[0]][position[1]] 
        @map[position[0]][position[1]] = BOT
      else
        @map[position[0]][position[1]] = @map[position[0]][position[1]].next
      end
      print_map
      sleep(time_to_sleep) 
      system "clear" 
    end
  end

  def display(time_to_sleep=0.3) 
    system "clear"
    while @bot_movement.size > 0 
      position = @bot_movement.shift 
      @map[position[0]][position[1]] = BOT
      print_map
      sleep(time_to_sleep) 
      @map[position[0]][position[1]] = EMPTY_CELL
      system "clear" 
    end
  end

  def print_map
    @map.each do |row| 
      puts row
    end
  end
end
