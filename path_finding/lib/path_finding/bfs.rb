class Bfs < Algorithm

  attr_reader :graph, :parent

  def run(start, goal) 
    distance = Hash.new(Float::INFINITY)
    @parent = Hash.new(nil) 
    queue = Queue.new
    distance[start] = 0 
    queue.push(start) 

    while !queue.empty? 
      current = queue.pop 
      graph.get_neighbors(current).each do |n| 
        if distance[n] == Float::INFINITY
          distance[n] = distance[current] + 1 
          parent[n] = current
          queue.push(n) 
          if n == goal 
            break 
          end
        end
      end
    end
    reconstruct_path(parent, start, goal) 
  end
end
