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

# Technically incorrect implementation as [0,1] is returned for 
# fibs_rec(0) but fuck overcomplicating for that
def fibs_rec(num, arr = [0, 1])
  if arr.length >= num
    return arr[0...num]
  else
    arr << arr[-1] + arr[-2] 
    return fibs_rec(num, arr)  
  end
end

p fibs_rec(8)