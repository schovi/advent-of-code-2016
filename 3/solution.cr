input = File.read(File.join(__DIR__, "input"))

possible_triangles = input.split(/\s+/).map(&.to_i?).compact.in_groups_of(3, 0)

triagles = possible_triangles.select do |(a, b, c)|
  (a + b > c) && (a + c > b) && (b + c > a)
end

p triagles.size