def read_input
  tree_map = Array.new
  File.open('input.txt', 'r') do |f|
    f.each_line do |line|
      row = Array.new
      line.each_char do |c|    
        case c
        when '.'
          row << false
        when '#'
          row << true
        end
      end
      tree_map << row
    end
  end
  return tree_map
end

def print_debug_row(row)
  row.each do |c|
    if c
      print '#'
    else
      print '.'
    end
  end
  puts #cr
end

def traverse_slope(map, right, down)
  x = y = count = 0
  width = map.first.size
  map.each_with_index do |row, index|
    next unless index % down == 0
    if row[x]
      #tree
      count += 1
    end
    new_x = (x + right) % width
    x = new_x
  end
  return count
end

def do_it
  tree_map = read_input
  firste = traverse_slope(tree_map, 1, 1)
  seconde = traverse_slope(tree_map, 3, 1)
  thirde = traverse_slope(tree_map, 5, 1)
  forth = traverse_slope(tree_map, 7, 1)
  fifth = traverse_slope(tree_map, 1, 2)
  firste * seconde * thirde * forth * fifth
end

puts do_it()
