require 'spec_helper'

describe BotMemory do 

  subject { BotMemory.new } 

  it "returns correct values if memory is empty" do 
    expect(subject.first_seen([Vector[1,2]] )).to eq [] 
    expect(subject.seen_all_neighbors? Vector[2,3]).to eq false
  end

  it "populates seen_cells and walls" do 
    subject.save_seen([Vector[1,1], Vector[1,2], Vector[2,1]], [Vector[0,1], Vector[1, 0]])
    seen_hash = { Vector[1,1] => 1, Vector[1,2] => 1, Vector[2,1] => 1}
    expect(subject.seen_cells).to eq  seen_hash
    walls_hash = { Vector[0,1] => 1, Vector[1, 0] => 1 } 
    expect(subject.walls).to eq walls_hash
  end

  it "returns the newly seen cells" do 
    subject.save_seen([Vector[1,1], Vector[1,2], Vector[2,1]], [Vector[0,1], Vector[1, 0]])
    subject.save_seen([Vector[2,1]], [])
    subject.visited_cells[Vector[1,1]] += 1
    expect(subject.first_seen( [Vector[1,1], Vector[1,2], Vector[2,1]]) ).to eq [Vector[1,1], Vector[1,2]]
  end

  it "constructs a grid from memory" do 
    subject.save_seen([Vector[1,1], Vector[1,2], Vector[2,1]], [Vector[0,1], Vector[1, 0]])
    grid = subject.construct_grid 
    expect(grid.is_a? Grid).to eq true 
    free_cells, walls = grid.get_neighbors(Vector[1,1], with_walls=true)
    expect(free_cells).to eq [Vector[2,1], Vector[1,2]]
    expect(walls).to eq [Vector[0,1], Vector[1, 0]]
  end


  context "#get_last_seen_cell" do 
    it "returns the one we added "  do 
      subject.save_seen( [Vector[1,1]], [] ) 
      expect(subject.get_last_seen_cell).to eq Vector[1,1] 
    end

    it "returns the last we added" do 
      subject.save_seen( [Vector[1,1]], [] ) 
      subject.save_seen( [Vector[1,2], Vector[1,3], Vector[1,4]], []) 
      expect(subject.get_last_seen_cell).to eq Vector[1,4] 
    end

    it "returns the last we haven't seen all its neighbors" do 
      subject.save_seen( [Vector[0,1], Vector[1,0], Vector[2,1], Vector[1,2], Vector[1,1]], [] ) 
      expect(subject.get_last_seen_cell).to eq Vector[1,2] 
    end

    it "returns the last cell unless it was already visited" do 
      subject.save_seen( [Vector[0,1], Vector[1,0], Vector[2,1], Vector[1,2], Vector[1,1]], [] ) 
      subject.visited_cells[Vector[1,2]] += 1
      expect(subject.get_last_seen_cell).to eq Vector[2,1] 
    end
  end 
end

