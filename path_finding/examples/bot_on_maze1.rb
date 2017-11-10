$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "path_finding"

maze_file = './data/maze1.txt'
builder = GridBuilder.new 
grid = builder.get_grid_from_file(maze_file) 

bot = Bot.new(grid, grid.bot_position) 
bot.move

view = MovementView.new(maze_file, bot.path) 
view.display(0.1) 

