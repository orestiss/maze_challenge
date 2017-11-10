require 'set'

class AStar < Algorithm

  attr_reader :graph, :priority_queue

  def run(start, goal) 
    @priority_queue = PriorityQueue.new 
    closed_set = Set.new
    came_from = Hash.new
    g_score = Hash.new(Float::INFINITY) 
    g_score[start] = 0
    
    priority_queue.f_score[start] = heuristic_cost_estimate(start, goal) 
    priority_queue.insert(start)

    while not priority_queue.empty?
      current = priority_queue.pop  
      if current == goal 
        return reconstruct_path(came_from, start, goal) 
      end
      closed_set.add(current) 
      graph.get_neighbors(current).each do |neighbor| 
				if closed_set.include?(neighbor)
					next
				end
        tentative_g_score = g_score[current] + 1 # dist current to neighbor
        if tentative_g_score >= g_score[neighbor]
          next
        end
        came_from[neighbor] = current 
        g_score[neighbor] = tentative_g_score
        priority_queue.update_f_score(neighbor, g_score[neighbor] + heuristic_cost_estimate(neighbor, goal)) 
        if not priority_queue.include?(neighbor) 
          priority_queue.insert(neighbor) 
        end
      end
    end
    return []
  end

  def heuristic_cost_estimate(start, goal) 
    Grid.manhattan(start, goal)
  end
end

