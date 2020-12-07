def read_input
  groups_questions = Array.new
  groups_questions_counts = Array.new
  group = Hash.new {|h,k| h[k] = 0 }
  
  File.open('input.txt', 'r') do |f|
    f.each_line do |line, index|
      answers = line.chomp.chars
      answers.each do |question|
        group[question] += 1
      end

      if answers.empty?
        groups_questions << group
        groups_questions_counts << group.keys.count
        group = Hash.new {|h,k| h[k] = 0 }
        next
      end

    end
    groups_questions << group
    groups_questions_counts << group.keys.count

  end
  pp groups_questions
  return groups_questions_counts.sum
end

def do_it
  count = read_input
end

puts do_it()
