$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "path_finding"


# create the grid from file
maze_file = './data/maze4.txt'
builder = GridBuilder.new 
grid = builder.get_grid_from_file(maze_file) 

# instanciate the bot
#
# we can modify the way that the bot will 
# select cells to move back to from the last 
# seen available, that is the default, 
# to the first seen by providing as input 
# a Queue to replace the Stack that is the 
# default data structure used in BotMemory
#
bot = Bot.new(grid, grid.bot_position, nil, Queue.new) 

bot.move 

# use the bot.path to display its movement 
view = MovementView.new(maze_file, bot.path) 
view.display_incrementing_bot(0.1)

