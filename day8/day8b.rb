def build_program(input)
  program = Hash.new{|h,k| h[k] = Hash.new }
  input.split("\n").each_with_index do |line, index|
    /(?<opcode>.*)\s(?<argument>[+|-]\d*)/ =~ line
    program[index] = {
      opcode: opcode,
      argument: argument.to_i
    }
  end
  return program
end

def evaluate_program(program)
  program_pointer = 0
  accumulator = 0
  done = false
  program_monitor = Hash.new{|h,k| h[k] = false } 
  while !done
    if program_monitor[program_pointer]
      return false
    end
    program_monitor[program_pointer] = true
    case program[program_pointer][:opcode]
    when 'jmp'
      program_pointer += program[program_pointer][:argument]
    when 'acc'
      accumulator += program[program_pointer][:argument]
      program_pointer += 1
    else
      program_pointer += 1
    end
    if program_pointer >= program.keys.count
      done = true
    end
  end
  return accumulator
end

def deep_copy_hash(hash_of_hashes)
  retval = Hash.new
  hash_of_hashes.each do |(k,v)|
    retval[k] = v.dup
  end
  return retval
end

def check_program(program)
  scanner = 0
  success = false

  while !success
    test_program = deep_copy_hash(program)
    while !%w(jmp nop).include? program[scanner][:opcode]
      scanner +=1
    end
    case test_program[scanner][:opcode]
    when 'jmp'
      test_program[scanner][:opcode] = 'nop'
    when 'nop'
      test_program[scanner][:opcode] = 'jmp'      
    end
    success = evaluate_program(test_program)
    scanner += 1
  end
  return success
end

def do_it
  prog = build_program(File.open('input.txt').read)
  check_program(prog)
end

puts do_it()
