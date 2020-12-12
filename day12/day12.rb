HEADINGS = { N: 1,
             E: 1, 
             S: -1,
             W: -1 }
TURNINGS = { R: 1,
             L: -1 }

@headings = -> (x) { HEADINGS.keys.include? x}
@turnings = -> (x) { TURNINGS.keys.include? x}
@x = @y = 0
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

def move(direction, amount)
  axis_mod = @axis_mod.call(direction)
  case direction
  when :N, :S
    @y += amount * axis_mod
  when :E, :W
    @x += amount * axis_mod
  end
end

def go_forward(amount)
  move(@heading.call, amount)
end

def do_it
  course = build_course(File.open('input.txt').read)
  course.each do |(_k, command_hash)|
    command = command_hash[:command]
    argument = command_hash[:argument]
    case command
    when @headings
      move(command, argument)
    when @turnings
      nineties = argument / 90
      @heading_index = (@heading_index + (TURNINGS[command] * nineties)) % HEADINGS.keys.length
    when :F
      go_forward(argument)
    end
  end

  return @y.abs + @x.abs
end

pp do_it()
