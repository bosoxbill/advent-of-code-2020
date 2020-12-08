@can_contain = []

def read_input
  bag_containers = Hash.new{|h,k| h[k] = Array.new }
  File.open('input.txt', 'r') do |f|
    f.each_line do |line|
      bag, contains = line.split('bags contain')

      if contains =~ /no other bag/
        next
      end
      
      numbers_and_bags = contains.split(',')
      numbers_and_bags.each do |nums_and_bags|
        /(?<number>\d)\s(?<inside_bag>.*)\sbag/i =~ nums_and_bags
        puts "#{nums_and_bags} #{number} #{inside_bag}"
        bag_containers[bag.strip] << inside_bag.strip
      end
    end
  end
  return bag_containers
end

def can_contain?(containers, color, mine)
  if containers[color]
    contains = containers[color].include?(mine)
    if containers[color].any?
      containers[color].each do |nested_container|
        contains ||= can_contain?(containers, nested_container, mine)
      end
    end
    msg = contains ? 'DOES NOT' : 'DOES   '
    if contains
      @can_contain << color
    end
  else
    return false
  end
end

#courtesy elmward - to double-check mine; unused
def contains?(rules, container_color, color)
  rules[container_color].include?(color) || rules[container_color].any? do |sub_container_color|
    contains?(rules, sub_container_color, color)
  end
end


def do_it
  containers = read_input
  count = containers.keys.count do |color|
    can_contain?(containers, color, 'shiny gold')
  end
end

puts do_it()
