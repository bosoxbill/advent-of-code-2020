START_AT = 25
WINDOW = 25
CRACK_NUM = 27911108

def build_list(input)
  list = Hash.new
  input.split("\n").each_with_index do |line, index|
    list[index] = line.to_i
  end
  return list
end


def find_list(list)
  list.each_with_index do |(k1, v1), i1|
    sum = v1
    matching_list = Hash.new
    matching_list[k1] = v1
    list.each_with_index do |(k2, v2), i2|
      next if i2 <= i1
      matching_list[k2] = v2
      sum += v2
      if sum == CRACK_NUM
        return matching_list
      end
    end
  end
end

def do_it
  list = build_list(File.open('input.txt').read)
  matches = find_list(list)
  return matches.values.min + matches.values.max
end

puts do_it()
