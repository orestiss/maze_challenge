require "spec_helper"

describe AStar do 

  subject do 
    a_star = AStar.new 
    a_star.set_graph(grid) 
    a_star
  end

  let(:builder) { GridBuilder.new } 

  context "small empty grid"  do 
    let(:grid) { builder.get_grid_from_file('./spec/data/maze1.txt') } 

    it "returns a continuous path" do 
      path = subject.run(Vector[1,1], Vector[8,8] )
      expect( is_continuous? path ).to be true
    end

    it "retuns a path with the correct start, finish vectors" do 
      path = subject.run(Vector[1,1], Vector[8,8] )
      expect(path[0]).to eq Vector[1,1] 
      expect(path.last).to eq Vector[8,8] 
    end
  end 

  context "large empty grid" do 
    let(:grid) { builder.get_grid_from_file('./spec/data/big_empty_maze.txt') } 

    it "returns a path that matches the manhattan distance in empty grids" do 
      path = subject.run(Vector[1,1], Vector[98,98] )
      expect(path.length).to eq Grid.manhattan(Vector[1,1], Vector[98, 98]) + 1
    end
  end 

  context "grid with walls" do 
    let(:grid) { builder.get_grid_from_file('./spec/data/maze2.txt') } 

    it "finds the minimum path in a grid with walls" do 
      path = subject.run(Vector[4,4], Vector[1, 8] ) 
      expect(path.size).to eq 12
      path = subject.run(Vector[4,4], Vector[4, 8] ) 
      expect(path.size).to eq 9
    end

  end

end
