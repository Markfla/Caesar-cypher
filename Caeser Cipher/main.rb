# frozen_string_literal: true

def char_array_to_int(unencrypted_array, right_shift)
  unencrypted_array.map do |char|
    # Convert character to ASCII, shift it, and wrap around if necessary
    if char.match?(/[A-Za-z]/)
      base = char.ord < 91 ? 65 : 97
      (((char.ord - base + right_shift) % 26) + base).chr
    else
      char
    end
  end
end

def caesar_cipher(unencrypted, right_shift)
  unencrypted_array = unencrypted.chars
  int_array = char_array_to_int(unencrypted_array, right_shift)
  int_array.join
end

# Example usage:
puts caesar_cipher('Hello, World!', 3)  # Khoor, Zruog!
puts caesar_cipher('abcXYZ', 2)         # cdeZAB
puts caesar_cipher('xyz', -3)           # uvw
