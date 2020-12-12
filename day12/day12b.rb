HEADINGS = { N: 1,
             E: 1, 
             S: -1,
             W: -1 }
TURNINGS = { R: 1,
             L: -1 }

@headings = -> (x) { HEADINGS.keys.include? x}
@turnings = -> (x) { TURNINGS.keys.include? x}
@x = @y = 0
@waypoint_x = 10
@waypoint_y = 1
@heading_index = 1
@heading = -> () { HEADINGS.keys[@heading_index] }
@axis_mod = -> (dir) { HEADINGS[dir] }

def build_course(input)
  course = Hash.new{|h, k| h[k] = Hash.new}
  input.split("\n").each_with_index do |line, index|
    /(?<command>NSEWLRF)\s(?<argument>\d*)/ =~ line
    course[index][:command] = line[0].to_sym
    course[index][:argument] = line[1..-1].to_i
  end
  return course
end

def move_waypoint(direction, amount)
  axis_mod = @axis_mod.call(direction)
  case direction
  when :N, :S
    @waypoint_y += (amount * axis_mod)
  when :E, :W
    @waypoint_x += (amount * axis_mod)
  end
end

def rotate_waypoint(direction, degrees)
  new_waypoint_x = new_waypoint_y = 0
  if degrees % 360 == 0
    return
  end
  if degrees % 270 == 0
    new_dir = (TURNINGS.keys - [direction]).first
    new_deg = 90
    return rotate_waypoint(new_dir, new_deg)
  end
  if degrees % 180 == 0
    @waypoint_x *= -1
    @waypoint_y *= -1
  elsif degrees % 90 == 0
    case direction
    when :L
      new_waypoint_y = @waypoint_x
      new_waypoint_x = @waypoint_y * -1
    when :R
      new_waypoint_y = @waypoint_x * -1
      new_waypoint_x = @waypoint_y
    end
    @waypoint_x = new_waypoint_x
    @waypoint_y = new_waypoint_y
  end
end

def go_forward(amount)
  amount.times do
    @x += @waypoint_x
    @y += @waypoint_y
  end
end

def do_it
  course = build_course(File.open('input.txt').read)
  course.each do |(_k, command_hash)|
    command = command_hash[:command]
    argument = command_hash[:argument]
    case command
    when @headings
      move_waypoint(command, argument)
    when @turnings
      rotate_waypoint(command, argument)
    when :F
      go_forward(argument)
    end
  end

  return @y.abs + @x.abs
end

pp do_it()
