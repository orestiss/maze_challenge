$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "path_finding"

maze_file = './data/maze3.txt'

builder = GridBuilder.new 

grid = builder.get_grid_from_file(maze_file) 

bot = Bot.new(grid, grid.bot_position) 
bot.move

# display doesn't work on large grids, 
# we could implement a relative 
# to the bots position display
puts bot.path
puts bot.result 
puts bot.path.last


