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

map = {} of Tuple(Int32,Int32) => Bool
coords = { 0, 0, :north }
coords = steps.reduce(coords) do |( x, y, face ), ( turn, length )|
  face = directions[turn][face]
    
  found = false
  
  1.upto(length) do 
    case face
    when :north
      y += 1
    when :east
      x += 1
    when :south
      y -= 1
    when :west
      x -= 1
    end

    coords = { x, y, face }

    if map[{ x, y }]?
      found = coords
      break 
    end

    map[{ x, y }] = true
  end

  if found
    break coords
  end

  coords
end

x, y = coords

total = x.abs + y.abs

p total