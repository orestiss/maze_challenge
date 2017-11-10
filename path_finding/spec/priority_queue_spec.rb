require "spec_helper"


describe PriorityQueue do 

  subject { PriorityQueue.new } 

  it "should be able to insert elements" do 

    subject.insert(Vector[1,2])
    subject.insert(Vector[3,4])

    expect(subject.open_set).to include Vector[1,2] 
    expect(subject.open_set).to include Vector[3,4]

  end


  it "pops the first element if no score is defined" do 
    subject.insert(Vector[1,2])
    subject.insert(Vector[3,4])

    expect(subject.pop).to eq Vector[1,2]
    expect(subject.pop).to eq Vector[3,4] 
  end


  it "pops the element with the minimum f_score" do 
    subject.f_score[Vector[3,4]] = 3
    subject.f_score[Vector[5,4]] = 5
    subject.insert(Vector[1,2])
    subject.insert(Vector[3,4])
    subject.insert(Vector[5,4])
    expect(subject.pop).to eq Vector[3,4] 
    expect(subject.pop).to eq Vector[5,4] 
  end



  it "maintain the minHeap property with multiple inserts and pops" do 

    (1..100).each do 
      vec = Vector[rand(1..10000), rand(1..10000)] 
      subject.f_score[vec] = rand(1..1000) 
      subject.insert(vec) 
      expect(subject.isMinHeap).to eq true
    end

    while !subject.empty? 
      subject.pop 
      expect(subject.isMinHeap).to eq true 
    end
  end


end

