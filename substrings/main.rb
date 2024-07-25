def substrings(str, dictionary)
  substring_hash = Hash.new(0) 
  words = str.downcase.split
  words.each do |word|
    dictionary.each do |substring|
      if word.include?(substring)
        occurrences = word.scan(/(?=#{substring})/).count
        substring_hash[substring] += occurrences
      end
    end
  end

  return substring_hash
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
puts substrings("Howdy partner, sit down! How's it going?", dictionary)
