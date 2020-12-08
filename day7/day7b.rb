@can_contain = []

def read_input
  bag_contents = Hash.new{|h,k| h[k] = Array.new }
  File.open('input.txt', 'r') do |f|
    f.each_line do |line|
      bag, contains = line.split('bags contain')
      if contains =~ /no other bag/
        bag_contents[bag.strip] = []
        next
      end
      
      numbers_and_bags = contains.split(',')
      numbers_and_bags.each do |nums_and_bags|
        /(?<number>\d)\s(?<inside_bag>.*)\sbag/i =~ nums_and_bags
        bag_deets = {
          bag: inside_bag.strip,
          num: number.to_i
        }
        bag_contents[bag.strip] << bag_deets
      end
    end
  end
  return bag_contents
end

def count_contained(containers, color)
  counts = containers[color].collect do |nested_container|
    nested_container[:num] + 
      (nested_container[:num] * count_contained(containers, nested_container[:bag]))
  end
  return counts.sum
end

def do_it
  containers = read_input
  count_contained(containers, 'shiny gold')
end

puts do_it()
