def charArrayToInt(unEncryptedArray, rightShift)
  unEncryptedArray.map do |char|
    # Convert character to ASCII, shift it, and wrap around if necessary
    if char.match?(/[A-Za-z]/)
      base = char.ord < 91 ? 65 : 97
      ((char.ord - base + rightShift) % 26 + base).chr
    else
      char
    end
  end
end

def caesar_cipher(unEncrypted, rightShift)
  unEncryptedArray = unEncrypted.split('')
  intArray = charArrayToInt(unEncryptedArray, rightShift)
  encryptedString = intArray.join('')
  return encryptedString
end

# Example usage:
puts caesar_cipher("Hello, World!", 3)  # Khoor, Zruog!
puts caesar_cipher("abcXYZ", 2)         # cdeZAB
puts caesar_cipher("xyz", -3)           # uvw
