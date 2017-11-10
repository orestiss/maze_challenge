require "spec_helper"

describe Grid do

	context "load grid from file" do 
		let(:grid) do 
			builder = GridBuilder.new 
			grid = builder.get_grid_from_file('./spec/data/maze1.txt')
		end

		it "returns the correct neighbors" do

			expect(grid.is_a? Grid).to eq true
			neighbors = grid.get_neighbors(Vector[1,1]) 

			expect(neighbors).to include(Vector[1, 2])
			expect(neighbors).to include(Vector[2, 1])
			expect(neighbors).not_to include(Vector[0, 1])
			expect(neighbors).not_to include(Vector[1, 0])
		end

    it "checks if goal is in position" do 
			expect(grid.is_goal?(Vector[3,4])).to eq true
			expect(grid.is_goal?(Vector[5,5])).to eq false
    end

    it "raises an out of bounds exception" do 
      expect {grid.get_neighbors(Vector[15, 15]) }.to raise_error(OutOfBoundsError)
    end

	end

end

