$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "path_finding"

# create the grid from file
maze_file = './spec/data/maze5.txt'
builder = GridBuilder.new 
grid = builder.get_grid_from_file(maze_file) 

# instanciate the bot
bot = Bot.new(grid, Vector[1,1] , Bfs.new) 
bot.move 

# use the bot.path to display its movement 
view = MovementView.new(maze_file, bot.path) 
view.display_incrementing_bot(0.1)

