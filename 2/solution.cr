input = File.read(File.join(__DIR__, "input"))

instructions = input.split("\n").map { |line| line.split(//).map(&.char_at(0)) }

keypad = {
 { 1, 2, 3},
 { 4, 5, 6},
 { 7, 8, 9},
}

jumps = {} of Int32 => Hash(Char, Int32)

keypad.each.with_index do |line, y|
  line.each.with_index do |key, x|
    jumps[key] = {
      'U' => keypad[y == 0 ? 0 : y - 1][x],
      'R' => keypad[y][x == 2 ? 2 : x + 1],
      'D' => keypad[y == 2 ? 2 : y + 1][x],
      'L' => keypad[y][x == 0 ? 0 : x - 1],
    }
  end
end

# Button 5
button = 5
code = instructions.map do |moves|
  button = moves.reduce(button) do |button, move|
    jumps[button][move]
  end
end

p code.join