def read_input
  passes = Hash.new
  highest = 0
  File.open('input.txt', 'r') do |f|
    f.each_line do |line|
      row_data = line[0..6].chars
      column_data = line[7..9].chars
      row = binary_find(0, 127, row_data)
      column = binary_find(0, 7, column_data)
      arr = [row, column]
      if passes[arr]
        raise "WTF passes is duplicated? #{passes[arr]}"
      end
      passes[arr] ||= Hash.new
      passes[arr][:taken] = true
      passes[arr][:checksum] = row * 8 + column
      if passes[arr][:checksum] > highest
        highest = passes[arr][:checksum]
      end
    end
  end
  return highest
end

def binary_find(start, limit, dir_list)
  if(start == limit)
    return start
  end
  range = (start..limit).to_a
  half_size = range.size / 2
  first_half, second_half = range.each_slice(half_size).to_a
  case dir_list.shift
  when 'F', 'L'
    return binary_find(first_half.first, first_half.last, dir_list)
  else
    return binary_find(second_half.first, second_half.last, dir_list)
  end
end

def do_it
  highest = read_input
end

puts do_it()
