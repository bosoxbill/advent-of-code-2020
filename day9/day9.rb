START_AT = 25
WINDOW = 25

def build_list(input)
  list = Hash.new
  input.split("\n").each_with_index do |line, index|
    list[index] = line.to_i
  end
  return list
end

def check_number(list, position)
  start = position - WINDOW
  finish = position - 1
  range = (start..finish)
  raise "LEARN MATH U DUNCE!" unless range.count == WINDOW
  to_check = list.slice(*range.to_a)
  match = false
  to_check.each do |(k1, v1)|
    to_check.each do |(k2, v2)|
      next if k1 == k2
      match = true if v1 + v2 == list[position]
    end
  end
  return match
end

def do_it
  list = build_list(File.open('input.txt').read)
  list.each do |(line, number)|
    next if line < START_AT
    unless check_number(list, line)
      return "#{number} on line #{line} is invalid"
    end
  end
end

puts do_it()
