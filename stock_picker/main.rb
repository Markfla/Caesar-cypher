def stockPicker(stocks)
  min_val = Float::INFINITY
  max_profit = 0

  stocks.each do |price|
    if price < min_val
      min_val = price
    elsif price - min_val > max_profit
      max_profit = price - min_val
    end
  end

  return max_profit
end

puts stockPicker([17, 3, 6, 9, 15, 8, 6, 1, 10])
