def fibs(num)
  arr = [0,1]
  if num == 0 || num == 1 
    return arr[0..num]
  else 
    (2..num).each do |i|
      arr[i] = arr[i-1] + arr[i-2]
    end
  end
  return arr
end

p fibs(8)