h = Hash.new
valid = Array.new
invalid = Array.new

def password_valid?(password, first, second, letter)
  valid_count = 0
  valid_count += 1 if password[first] == letter
  valid_count += 1 if password[second] == letter
  return valid_count == 1
end

File.open('input.txt', 'r') do |f|
  f.each_line do |line|
    range, letter_with_colon, password = line.split(' ')
    first_position_char, second_position_char = range.split('-')
    first_position = first_position_char.to_i - 1
    second_position = second_position_char.to_i - 1
    letter = letter_with_colon.chars.first
    if password_valid?(password, first_position, second_position, letter)
      valid << password
    else
      invalid << password
    end
  end
end

puts "#{valid.count} valid passwords, #{invalid.count} invalid"

