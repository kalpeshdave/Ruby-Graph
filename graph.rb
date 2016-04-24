class Graph
	def initialize(graph)
		@paths =  Hash.new { |k, v| k[v] = {} }
		@nodes = Array.new
		graph.each do |initial, final, size|
			raise("Weight is not positive.") if size < 0
			add_path(initial, final, size)
		end		
	end
	
	# based of wikipedia's pseudocode: http://en.wikipedia.org/wiki/Dijkstra's_algorithm
	
	def find_shortest_path(initial_node, final_node)
		unless @nodes.include?(initial_node) && @nodes.include?(final_node)
		  raise("Either of the nodes not found in the Graph") 
		end
		distance = {}
	        previous = {}
		distance[initial_node] = 0                      # Distance from initial_node to initial_node
	        previous[initial_node] = nil
		nodes_counted = @nodes
			
		nodes_counted.each do |n|
		      if n != initial_node            
			  distance[n] = Float::INFINITY     # Unknown distance function from initial_node to final_node
			  previous[n] = nil            	   # Previous node in optimal path from initial_node
			end
		end

		until nodes_counted.empty? 
		
			u = distance.select{|k,v| nodes_counted.include?(k)}.min_by{|k,v| v}.first  # Source node in first case
			break if (distance[u] == Float::INFINITY)
			nodes_counted.delete(u)
			
			@paths[u].keys.each do |v|
				alt = distance[u] + @paths[u][v]
				if alt < distance[v]               # A shorter path to v has been found
					distance[v] = alt
					previous[v] = u
				end
			end
		end
	  
		path = []
		current = final_node
		while current
			path.unshift(current)
			current = previous[current]
		end
    
		return distance[final_node], path

	end
	
	private
	
	def add_path(initial, final, size)
		@paths[initial][final] = size
	        @paths[final][initial] = size 
	        @nodes << initial << final
	        @nodes.uniq!
	end	
end

