class PriorityQueue

  attr_reader :open_set
  attr_accessor :f_score

  def initialize
    @open_set = [nil] 
    @f_score = Hash.new(Float::INFINITY) 
  end

  def insert(item) 
    open_set.push(item) 
    swim(size) 
  end

  def pop
    return nil if size <= 0 
    first_item = open_set.delete_at(1) 

    return first_item if size == 0 
    last_item = open_set.pop
    open_set.insert(1, last_item) 

    sink(1) 
    first_item 
  end

  def pop2
    return nil if size <= 0 
    open_set[1], open_set[size] = open_set[size], open_set[1]
    first_item = open_set.pop
    sink(1) 
    first_item 
  end

  def update_f_score(item, score) 
    f_score[item] = score
    heapify
  end

  def empty? 
    size == 0 
  end

  def include? item
    open_set.include? item 
  end

  def isMinHeap(k=1) 
    return true if k > size
    left = 2*k 
    right = 2*k + 1 
    return false if left <= size && more?(k, left) 
    return false if right <= size && more?(k, right) 
    return isMinHeap(left) && isMinHeap(right) 
  end

  private 

    def heapify
      (1..size).reverse_each do |i|
        sink(i) 
      end
    end

    def size
      open_set.size - 1
    end

    def more?(k1, k2) 
      f_score[open_set[k1]] > f_score[open_set[k2]] 
    end

    def exchange(k1, k2) 
      open_set[k1], open_set[k2] = open_set[k2], open_set[k1]
    end

    def swim(k) 
      while k > 1 && more?(k/2, k) 
        exchange(k, k/2) 
        k = k/2
      end
    end

    def sink(k) 
      while 2*k <= size 
        j = 2*k 
        j += 1 if j < size && more?(j, j+1) 
        break if !more?(k, j) 
        exchange(k, j) 
        k = j 
      end
    end
end
