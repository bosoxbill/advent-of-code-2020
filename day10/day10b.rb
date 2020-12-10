def build_list(input)
  list = Array.new
  input.split("\n").each do |line|
    list << line.to_i
  end
  return [0, *list.sort, list.max + 3]
end


def do_it
  list = build_list(File.open('input.txt').read)
  paths = Hash.new{|h, k| h[k] = 0 }
  paths[0] = 1 #set the outlet or none of this works, dummy!

  list[(0..-2)].each do |item|
    [1, 2, 3].each do |allowed_jump|
      destination = item + allowed_jump
      #print "checking to see if #{destination} is in list..."
      if list.include? destination
        #puts "it is! #{paths[destination]} - #{paths[item]}"
        paths[destination] += paths[item]
      else
        #puts 'nope!'
      end
    end
  end

  return paths[paths.keys.sort.last]
end

pp do_it()

