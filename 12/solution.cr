def program(input)
  instructions = input.split("\n").map do |line|
    tokens = line.split(/\s+/)
  end

  registry = {
    'a' => 0,
    'b' => 0,
    'c' => 0,
    'd' => 0
  }

  cursor = 0

  loop do
    break if cursor >= instructions.size
    instruction = instructions[cursor]

    case instruction[0]
    when "cpy"
      _, from, to = instruction
      
      to_register = to.char_at(0)
      from_register = from.char_at(0)

      if from_register.number?
        registry[to_register] = from.to_i32
      else
        registry[to_register] = registry[from_register]
      end
    when "jnz"
      _, test, offset = instruction
      
      test_register = test.char_at(0)

      is_register? = !test_register.number?

      if (is_register? && registry[test_register] != 0) || (!is_register? && test.to_i32 != 0)
        offset = offset.to_i32
        cursor += offset
        next
      end
    when "inc"
      _, register = instruction
      registry[register.char_at(0)] += 1
    when "dec"
      _, register = instruction
      registry[register.char_at(0)] -= 1
    end

    cursor += 1
  end

  registry
end

registry = program(File.read(File.join(__DIR__, "input")))

p registry
