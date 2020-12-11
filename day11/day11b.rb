def build_floor(input)
  floor = Array.new
  input.split("\n").each do |line|
    row = line.chars
    floor << row
  end
  puts "read a floor that is #{floor.count} tall and #{floor.first.count} wide"
  return floor
end

def skip_coords?(x, y, new_x, new_y)
  #print "testing #{x},#{y} - #{new_x},#{new_y}"
  same = (x == new_x) && (y == new_y)
  in_line = (x == new_x) || (y == new_y)
  in_diagonal = (new_x - x) == (new_y - y)

  use = (in_line || in_diagonal) && !same
  #puts "...#{!use}"
  !use
end

def seat_change(floor, x, y)
  new_occupancy = false
  current_occupancy = floor[y][x]
  occupied = 0
  width = floor.first.count
  height = floor.count
  ray_length = width + height
  (0..height).each do |new_y|
    (0..width).each do |new_x|
      next if skip_coords?(x, y, new_x, new_y) #skip origin
      if floor[new_y] && floor[new_y][new_x]
        if floor[new_y][new_x] == '#'
          occupied += 1
        end
      end
    end
  end
  case current_occupancy
  when '#'
    if occupied >= 5
      new_occupancy = 'L'
    end
  when 'L'
    if occupied == 0
      new_occupancy = '#'
    end
  end
  return new_occupancy
end

def print_floor(floor)
  floor.each do |row|
    puts row.join ''
  end
end

def do_it
  floors = Array.new
  floors << build_floor(File.open('test_input.txt').read)

  done = false
  counter = 0

  while !done
    puts "ROUND #{counter}"
    print_floor(floors.last)
    new_floor = Array.new
    counter += 1
    changes = 0
    floors.last.each_with_index do |row, y|
      new_floor << Array.new
      row.each_with_index do |seat, x|
        case seat
        when '#', 'L'
          change = seat_change(floors.last, x, y)
          if !!change
            changes += 1
            new_floor[y] << change
          else
            new_floor[y] << seat
          end
        else
          new_floor[y] << seat
        end
      end
    end
    floors << new_floor
    done = (changes == 0) 
    puts "#{changes} changes!"
    puts ""
  end

  floors.last.sum{|row| row.count{|seat| seat == '#'}}
end

pp do_it()
