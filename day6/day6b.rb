def read_input
  groups_questions = Array.new
  groups_questions_all_yes_counts = Array.new
  group = Hash.new {|h,k| h[k] = 0 }
  group_size = 0
  
  File.open('input.txt', 'r') do |f|
    f.each_line do |line, index|
      answers = line.chomp.chars
      answers.each do |question|
        group[question] += 1
      end

      if answers.empty?
        groups_questions << group
        puts 'summing for:' + group_size.inspect
        groups_questions_all_yes_counts << group.values.count{|count| count == group_size}
        group = Hash.new {|h,k| h[k] = 0 }
        group_size = 0
        next
      else
        group_size += 1
      end

    end
    groups_questions << group
    groups_questions_all_yes_counts << group.values.count{|count| count == group_size}
  end

  pp groups_questions
  return groups_questions_all_yes_counts.sum
end

def do_it
  count = read_input
end

puts do_it()
