lines = File.read_lines(File.join(__DIR__, "input"))

possible_triangles = lines.map(&.strip.split(/[\s\n]+/).map(&.to_i)).transpose.flatten.in_groups_of(3, 0)

triagles = possible_triangles.select do |(a, b, c)|
  (a + b > c) && (a + c > b) && (b + c > a)
end

p triagles.size