input = File.read(File.join(__DIR__, "input"))

signal = input.split("\n").map(&.chars)

signal.first.size.times do |i|
  memo = {} of Char => Int32

  signal.each do |chars|
    char = chars[i] 
    memo[char] ||= 0
    memo[char] += 1 
  end

  char, _ = memo.min_by do |char, val| val end

  print char
end

print "\n"