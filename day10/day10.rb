def build_list(input)
  list = Array.new
  input.split("\n").each do |line|
    list << line.to_i
  end
  return list
end

def do_it
  list = build_list(File.open('input.txt').read).sort
  results = Hash.new{|h, k| h[k] = 0 }
  list[1..list.length].each_with_index do |second, index|
    first = list[index - 1]
    gap = second - first
    next if gap > 3
    raise "WTF can't bridge gap between #{first} and #{second}" if gap > 3
    results[gap] += 1
  end
  results[3] += 1
  pp results
  return results[1] * results[3]
end

pp do_it()
