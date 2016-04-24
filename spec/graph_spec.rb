require 'spec_helper'

describe Graph do
	before :each do
	    @object = Graph.new  [['a', 'd', 5], ['c', 'b', 6], [ 'd', 'b', 3]]
	end
    
	describe "#new" do
	    it "should be an instance of a Graph object" do
		expect(@object).to be_a Graph
	    end
	end
    
	describe "#validate input" do
	    it "should be raise an error message if input is invalid" do
		expect { @object.find_shortest_path('a', 'e') }.to raise_error(RuntimeError, "Either of the nodes not found in the Graph")
	    end
	end
    
	describe "#find_shortest_path between node a and node b" do
		 it "should find the shortest distance" do
			 result = @object.find_shortest_path('a', 'b')
			 expect(result).not_to be_empty
			 expect(result[0]).to   eq(8)
		 end
		 it "should find the shortest path" do
			 result = @object.find_shortest_path('a', 'b')
			 expect(result).not_to be_empty
			 expect(result[1]).to be_kind_of(Array)
		 end
	end
	
end