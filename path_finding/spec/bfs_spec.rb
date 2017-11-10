require "spec_helper"

describe Bfs do 

  subject { Bfs.new } 
  let(:builder) { GridBuilder.new } 

  context "empty grid" do 

    let(:grid) { builder.get_grid_from_file('./spec/data/maze1.txt') }

    it "should find a continuous path from start to finish" do 
      subject.set_graph(grid) 
      path = subject.run(Vector[2,2], Vector[6,6])
      expect( is_continuous? path).to be true 
      expect( path.first ).to eq Vector[2,2] 
      expect( path.last ).to eq Vector[6,6] 
    end

  end

  context "running on a grid with walls" do 
    let(:grid) { builder.get_grid_from_file('./spec/data/maze2.txt') }
    let(:start) { Vector[4,4] } 
    let(:finish) { Vector[1,8] } 

    it "should return continuous path from start to finish" do 

      subject.set_graph(grid) 
      path = subject.run(start, finish) 
      expect( is_continuous? path).to be true 
      expect( path.first ).to eq start
      expect( path.last ).to eq finish 
    end
  end

  context "running on a grid with rooms" do 
    
    let(:grid) { builder.get_grid_from_file('./spec/data/maze6.txt') }
    let(:start) { Vector[4,4] } 
    let(:finish) { Vector[1,4] } 

    it "should return continuous path from start to finish" do 
      subject.set_graph(grid) 
      path = subject.run(start, finish) 
      expect( is_continuous? path).to be true 
      expect( path.first ).to eq start
      expect( path.last ).to eq finish 
    end
  end


end
