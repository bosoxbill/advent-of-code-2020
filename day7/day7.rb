def unfuck_bag_name(bag_name)
  adj, color, junk = bag_name.split(' ')
  return "#{adj} #{color}"
end

def read_input
  bag_contents = Hash.new{|h,k| h[k] = Hash.new }
  bag_containers = Hash.new{|h,k| h[k] = Array.new }
  File.open('input.txt', 'r') do |f|
    f.each_line do |line|
      bag, contains = line.split('contain')
      bag = unfuck_bag_name(bag)

      if contains =~ /no other bag/
        bag_contents[bag] = nil
        next
      end
      
      numbers_and_bags = contains.split(',')
      numbers_and_bags.each do |nums_and_bags|
        /(?<number>\d)\s(?<inside_bag>.*)/i =~ nums_and_bags
        contained = unfuck_bag_name(inside_bag)
        bag_contents[bag][contained] = number
        bag_containers[contained] << bag
      end
    end
  end
  pp bag_containers
  return bag_contents, bag_containers
end

def can_contain?(containers, color, mine)
  if containers[color]
    contains = containers[color].include?(mine)
    if containers[color].any?
      containers[color].each do |nested_container|
        contains ||= can_contain?(containers, nested_container, mine)
      end
    end
    return contains
  else
    return false
  end
end

def do_it
  contents, containers = read_input
  count = containers.keys.count do |color|
    can_contain?(containers, color, 'shiny gold')
  end
  return count
end

puts do_it()
