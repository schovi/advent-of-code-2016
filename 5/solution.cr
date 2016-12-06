require "crypto/md5"

input = "ugkcyxxp"

i = 0

result = [] of Char 
zeros = "00000"

0.step(by: 1) do |i|
  md5 = Crypto::MD5.hex_digest("#{input}#{i}")

  if md5.starts_with?(zeros)
    result.push(md5.char_at(5))
    break if result.size == 8
  end
end

p result.join()