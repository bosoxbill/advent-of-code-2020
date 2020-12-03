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

def traverse_slope(map, right, down)
  x = count = 0
  width = map.first.size
  map.each do |row|
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
  traverse_slope(tree_map, 3, 1)
end

puts do_it()
