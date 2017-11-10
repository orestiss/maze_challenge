$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "path_finding"

def is_continuous?(path) 
  from = path[0] 
  path[1..-1].each do |to|
    if Grid.manhattan(from, to) != 1 
      return false 
    end
    from = to 
  end
  true
end
