require "spec_helper"

describe GridBuilder do

  it "builds grid from file" do
    builder = GridBuilder.new
    grid = builder.get_grid_from_file('./spec/data/maze1.txt')
    expect(grid.is_a? Grid).to eq true
    neighbors = grid.get_neighbors(Vector[1,1]) 
    expect(neighbors).to include(Vector[1, 2])
    expect(grid.is_goal?(Vector[3,4])).to eq true
    expect(grid.is_goal?(Vector[5,5])).to eq false
  end


  it "builds a grid from array of vectors" do 
    builder = GridBuilder.new 
    free_cells = [Vector[1,1], Vector[1,2], Vector[2,1]]
    walls = [Vector[0, 0], Vector[0, 1]]
    grid = builder.get_grid_from_data(free_cells, walls) 
    expect(grid.is_a? Grid).to eq true
    neighbors = grid.get_neighbors(Vector[0, 0])
  end

  it "raises an invalid file exception, if it contains invalid characters" do 
    builder = GridBuilder.new
    expect { builder.get_grid_from_file('./spec/data/maze_invalid.txt') }.to raise_error InvalidFileError
  end

end

