def read_input
  passes = Hash.new
  highest = 0
  File.open('input.txt', 'r') do |f|
    f.each_line do |line|
      row_data = line[0..6].chars
      column_data = line[7..9].chars
      row = binary_find(0, 127, row_data)
      column = binary_find(0, 7, column_data)
      checksum = checksum(row, column)
      arr = [row, column]
      if passes[checksum]
        raise "WTF passes is duplicated? #{passes[arr]}"
      end
      passes[checksum] ||= Hash.new
      passes[checksum][:taken] = true
      passes[checksum][:arr] = arr
      if checksum > highest
        highest = checksum
      end
    end
  end
  return passes
end

def checksum(row, col)
 row * 8 + col
end

def find_missing(passes)
  (0..127).each do |row|
    (0..7).each do |col|
      chk = checksum(row, col)
      next if passes[chk]
      if passes[chk + 1] && passes[chk - 1]
        return checksum(row, col)
      end
    end
  end
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
  passes = read_input
  missing = find_missing(passes)
end

puts do_it()
