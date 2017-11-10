$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "path_finding"

def stress_priority_queue(priority_queue)
  (1..100000).each do |i|
    priority_queue.insert(i)
  end

  while ! priority_queue.empty? do 
    priority_queue.pop
  end
  puts(priority_queue.open_set)
end

priority_queue = PriorityQueue.new

stress_priority_queue(priority_queue)
