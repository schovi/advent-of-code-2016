input = File.read(File.join(__DIR__, "input"))

steps = input.split(",").map(&.strip).map do |step|
  { step[0], step[1..-1].to_i }
end

directions = {
  'R' => {
    north:  :east,
    east:   :south,
    south:  :west,
    west:   :north
  },
  'L' => {
    north:  :west,
    west:   :south,
    south:  :east,
    east:   :north
  }
}

coords = { 0, 0, :north }
coords = steps.reduce(coords) do |( x, y, face ), ( turn, length )|
  face = directions[turn][face]
    
  case face
  when :north
    y += length
  when :east
    x += length
  when :south
    y -= length
  when :west
    x -= length
  end

  { x, y, face }
end

x, y = coords

total = x.abs + y.abs

p total