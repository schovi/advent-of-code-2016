lines = File.read_lines(File.join(__DIR__, "input"))

instructions = lines.map(&.split(//).map(&.char_at(0)))

keypad = {
  {nil, nil, '1', nil, nil},
  {nil, '2', '3', '4', nil},
  {'5', '6', '7', '8', '9'},
  {nil, 'A', 'B', 'C', nil},
  {nil, nil, 'D', nil, nil},
}    

# x, y
position = {0, 2}

code = instructions.map do |moves|
  position = moves.reduce(position) do |position, move|
    x, y = position

    case move
    when 'U'
      y = y == 0 ? 0 : y - 1
    when 'R'
      x = x == 4 ? 4 : x + 1
    when 'D'
      y = y == 4 ? 4 : y + 1
    when 'L'
      x = x == 0 ? 0 : x - 1
    end

    if keypad[y][x] != nil
      {x, y}
    else
      position
    end
  end

  keypad[position[1]][position[0]]
end

p code.join