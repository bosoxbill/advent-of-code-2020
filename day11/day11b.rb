def build_floor(input)
  floor = Array.new
  input.split("\n").each do |line|
    row = line.chars
    floor << row
  end
  return floor
end

def skip_coords?(x, y, new_x, new_y)
  same = (x == new_x) && (y == new_y)
  in_line = (x == new_x) || (y == new_y)
  in_diagonal = (new_x - x).abs == (new_y - y).abs

  use = (in_line || in_diagonal) && !same
  !use
end

def seat_change(floor, x, y)
  new_occupancy = false
  current_occupancy = floor[y][x]
  width = floor.first.count
  height = floor.count
  ray_length = width + height #too long, who cares
  can_see = {
    n: false,
    ne: false,
    e: false,
    se: false,
    s: false,
    sw: false,
    w: false,
    nw: false
  }
  new_y = y
  new_x = x

  can_see.keys.each do |direction|
    next if can_see[direction]
    end_reached = false
    next if end_reached
    distance = 1
    while !end_reached
      case direction
      when :n
        new_y = y - distance
        new_x = x
        if new_y < 0
          new_y = 0
          end_reached = true
        end
      when :ne
        new_y = y - distance
        if new_y < 0
          new_y = 0
          end_reached = true
        end
        new_x = x + distance
        if new_x >= width
          new_x = width
          end_reached = true
        end
      when :e
        new_x = x + distance
        new_y = y
        if new_x >= width
          new_x = width
          end_reached = true
        end
      when :se
        new_x = x + distance
        if new_x >= width
          new_x = width
          end_reached = true
        end
        new_y = y + distance
        if new_y >= height
          new_y = height
          end_reached = true
        end
      when :s
        new_y = y + distance
        new_x = x
        if new_y >= height
          new_y = height
          end_reached = true
        end
      when :sw
        new_x = x - distance
        if new_x < 0
          new_x = 0
          end_reached = true
        end
        new_y = y + distance
        if new_y >= height
          new_y = height
          end_reached = true
        end
      when :w
        new_x = x - distance
        new_y = y
        if new_x < 0
          new_x = 0
          end_reached = true
        end
      when :nw
        new_x = x - distance
        if new_x < 0
          new_x = 0
          end_reached = true
        end
        new_y = y - distance
        if new_y < 0
          new_y = 0
          end_reached = true
        end
      end
      distance += 1
      if end_reached || skip_coords?(x, y, new_x, new_y)
        next
      end
      if floor[new_y] && floor[new_y][new_x]
        space = floor[new_y][new_x]
        if ['#', 'L'].include? space
          end_reached = true
          can_see[direction] = (space == '#')
        end
      end
    end
  end
  occupied = can_see.values.count{|v| !!v}
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
  floors << build_floor(File.open('input.txt').read)

  done = false
  counter = 0

  while !done
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
  end

  floors.last.sum{|row| row.count{|seat| seat == '#'}}
end

pp do_it()
