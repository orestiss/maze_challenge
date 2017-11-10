require "spec_helper"

describe Bot do 

  let(:grid) {  Grid.new([Vector[1,2], Vector[3,4], Vector[2,2] ], [Vector[0, 2]] ) } 
  subject { Bot.new(grid, Vector[1,2]) }
  let(:builder) { GridBuilder.new } 

  describe "#set_position" do 
    context "when not within reach" do 
      let(:position) { Vector[3,4] } 
      it "should raise ArgumentError" do 
        expect {subject.set_position(position) }.to raise_error ArgumentError
      end
    end

    context "when within reach" do 
      let(:position) {Vector[2, 2]} 
      before do 
        expect(subject.path).not_to include position
      end
      it "should add new position to path" do 
        subject.set_position(position)
        expect(subject.path).to include position
      end
      it "stops in first step" do 
        subject.move 
        expect(subject.path.size).to eq 2
      end
    end
  end

  describe "#move" do 
    context "when no moves available" do 
      let(:grid) {  Grid.new([ Vector[1,2]  ], [Vector[0, 2]] ) } 
      it "should have a path with only the initial position" do 
        subject.move
        expect(subject.path).to eq [Vector[1,2]] 
        expect(subject.result).to eq :fail 
      end
    end

    context "when one move available" do 
      let(:grid) {  Grid.new([ Vector[1,2], Vector[2,2] ], [Vector[0, 2]] ) } 
      it "should have a path with two positions, and :fail result" do 
        subject.move
        expect(subject.path).to eq [Vector[1,2], Vector[2,2] ] 
        expect(subject.result).to eq :fail
      end

      it "should result in found if goal is present" do 
        grid.set_goal_position(Vector[2,2]) 
        subject.move 
        expect(subject.path).to eq [Vector[1,2], Vector[2,2] ] 
        expect(subject.result).to eq :found
      end
    end


    context "four moves available" do 

      let(:grid) {  Grid.new([ Vector[1, 2], Vector[2, 2], Vector[2, 1], Vector[3, 2] ] , [Vector[0, 2]] ) } 

      it "should visit all positions" do 
        subject.move 
        expect(subject.path).to eq [ Vector[1,2], Vector[2,2], Vector[3,2], Vector[2,2], Vector[2,1]] 
        expect(subject.result).to eq :fail 
      end

      it "should find the goal" do 
        grid.set_goal_position(Vector[2,1]) 
        subject.move 
        expect(subject.path).to eq [ Vector[1,2], Vector[2,2], Vector[2,1]] 
        expect(subject.result).to eq :found
      end
    end


    context "high level tests" do 

      context "small empty room data file maze3" do 

        let(:grid) do 
          builder = GridBuilder.new 
          builder.get_grid_from_file('./spec/data/maze3.txt') 
        end

        it "should see all free cells" do 
          subject.move 
          expect(subject.memory.seen_cells.size).to eq grid.free_cells.size 
          expect(subject.result).to eq :fail
          expect(is_continuous? subject.path ) .to eq true 
        end

      end

      context "vertical and horizontal walls" do 

        let(:grid) do 
          builder.get_grid_from_file('./spec/data/maze4.txt') 
        end

        it "should see all free cells if there is no goal" do  
          subject.move 
          expect(subject.memory.seen_cells.size).to eq grid.free_cells.size 
          expect(subject.result).to eq :fail
          expect(is_continuous? subject.path ) .to eq true 
        end

        it "should find goal" do 
          grid.set_goal_position(Vector[12, 12]) 
          subject.move

          expect(subject.path.last).to eq Vector[12, 12] 
          expect(is_continuous? subject.path).to be true 
          expect(subject.result).to eq :found 
        end
      end

      context "diagonal walls" do 
        let(:grid) { builder.get_grid_from_file('./spec/data/maze5.txt') } 

        it "should see all free cells if there is no goal" do 
          subject.move 
          expect(subject.memory.seen_cells.size).to eq grid.free_cells.size 
          expect(subject.result).to eq :fail
          expect(is_continuous? subject.path ) .to eq true 
        end

        it "should find goal if present" do 
          goal_position = Vector[15, 16] 
          grid.set_goal_position(goal_position) 
          subject.move

          expect(subject.path.last).to eq goal_position
          expect(is_continuous? subject.path).to be true 
          expect(subject.result).to eq :found 
        end

      end

      context "using Bfs as a retreat algorithm" do 

        let(:grid) { builder.get_grid_from_file('./spec/data/maze5.txt') } 

        subject { Bot.new(grid, Vector[1,2], Bfs.new) }

        it "should see all free cells if no goal" do 
          subject.move 
          expect(subject.memory.seen_cells.size).to eq grid.free_cells.size 
          expect(subject.result).to eq :fail
          expect(is_continuous? subject.path ) .to eq true 
        end

        it "should find the goal" do 
          goal_position = Vector[15, 16] 
          grid.set_goal_position(goal_position) 
          subject.move
          expect(subject.path.last).to eq goal_position
          expect(is_continuous? subject.path).to be true 
          expect(subject.result).to eq :found 
       end
      end
    end
  end
end

