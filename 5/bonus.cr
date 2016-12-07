require "crypto/md5"

input = "ugkcyxxp"

i = 0

size = 8
done = 0
result = {} of Int32 => Char 
zeros = "00000"

range = ('0'..'7')
0.step(by: 1) do |i|
  md5 = Crypto::MD5.hex_digest("#{input}#{i}")

  if md5.starts_with?(zeros)
    position = md5.char_at(5)

    if range.includes?(position)
      index = position.to_i.as(Int32)

      if !result[index]?
        result[index] = md5.char_at(6)
        done += 1
      end
    end
 
    break if done == size
  end
end

sorted = result.to_a.sort { |val1, val2| val1[0] - val2[0] }

p sorted.map(&.[1]).join

# p result.join()