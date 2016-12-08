input = File.read(File.join(__DIR__, "input"))

matcher = /([a-z\-]+)\-(\d+)\[([a-z]+)\]/

data = input.split('\n').map do |line|
  result = matcher.match(line).not_nil!
  
  { 
    encryption: result[1],
    value: result[2].to_i,
    checksum: result[3] 
  }
end

def sort(data)
  data.to_a.sort do |(char1, val1), (char2, val2)|
    if val1 == val2
      char1 - char2
    else
      val2 - val1
    end
  end
end

def valid?(room)
  memory = {} of Char => Int32

  room[:encryption].each_char do |letter|
    if letter != '-'
      memory[letter] ||= 0
      memory[letter] += 1
    end
  end

  sorted_memory = sort(memory)

  decryption = sorted_memory[0..4].map(&.[0]).join()

  decryption == room[:checksum]
end

A_ORD = 'a'.ord
ABCDS_LEN = 26
 
def shift_char(char, shift)
  (((char.ord - A_ORD + shift) % ABCDS_LEN) + A_ORD).chr 
end

valid_rooms = data.select do |room| 
  valid?(room) 
end

names = valid_rooms.map do |room|
  shift_by = room[:value] % ABCDS_LEN

  decoded_text = String.build do |s|  
    room[:encryption].each_char do |char|
      s << (char == '-' ? ' ' : shift_char(char, shift_by))
    end
  end

  {
    name: decoded_text,
    id: room[:value]
  }
end

names.each do |name|
  p name
end