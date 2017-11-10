class Stack 
  def initialize 
    @stack_array = [] 
  end

  def push(element)
    return if element.nil?
    return if @stack_array.include? element
    @stack_array.push(element)
  end

  def pop
    @stack_array.pop 
  end

  def empty? 
    @stack_array.empty?
  end
end
