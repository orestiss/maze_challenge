class Algorithm

  def set_graph(graph) 
    @graph = graph
  end

  def run(start, goal) 
    fail NotImplementedError, "abstract method" 
  end

  def reconstruct_path(parent, start, goal) 
    path = [goal] 
    current = goal 
    while current != start 
      current = parent[current] 
      path.insert(0, current) 
    end
    path
  end
end
