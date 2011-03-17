class Array

  def average
    inject(:+).to_f / size unless size == 0
  end

end
