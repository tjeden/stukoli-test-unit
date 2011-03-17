class Array

  def average
    sum = 0
    count = 0
    each do |element|
      sum += element
      count += 1
    end
    sum.to_f/count if count != 0
  end

end
