class InvalidFileError < StandardError 
  attr_reader :file_path

  def initialize(file_path) 
    @file_path = file_path
    msg = "The characters allowed are '#', '-','*', '@' "
    super(msg) 
  end
end

class OutOfBoundsError < StandardError 
  def initialize
    msg = "the position was out of the bounds of the grid"
    super(msg) 
  end

end
