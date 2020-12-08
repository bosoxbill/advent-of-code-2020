@program = Hash.new{|h,k| h[k] = Hash.new }
@program_monitor = Hash.new{|h,k| h[k] = false }

def parse_input(input)
  input.split("\n").each_with_index do |line, index|
    /(?<opcode>.*)\s(?<argument>[+|-]\d*)/ =~ line
    @program[index] = {
      opcode: opcode,
      argument: argument.to_i
    }
  end
end

def evaluate_program
  program_pointer = 0
  accumulator = 0
  done = false
  while !done
    if @program_monitor[program_pointer]
      puts "LOOP! #{accumulator}"
      exit
    end
    @program_monitor[program_pointer] = true
    case @program[program_pointer][:opcode]
    when 'jmp'
      program_pointer += @program[program_pointer][:argument] - 1
    when 'acc'
      accumulator += @program[program_pointer][:argument]
    end
    program_pointer += 1
  end

end

def do_it
  parse_input(File.open('input.txt').read)
  evaluate_program
end

do_it()
