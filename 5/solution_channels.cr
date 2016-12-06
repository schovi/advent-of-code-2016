require "crypto/md5"

input = "ugkcyxxp"

result = [] of Char 

channel = Channel(Char).new
batch_channel = Channel(Nil).new
batch_size = 10

def compute(batch_channel, channel, input, i, batch_size)
  md5 = Crypto::MD5.hex_digest("#{input}#{i}")

  if md5.starts_with?("00000")
    channel.send(md5.char_at(5))
  end

  if i % batch_size == 0
    batch_channel.send(nil)
  end
end

spawn do
  loop do
    letter = channel.receive 
    result.push(letter)

    break if result.size == 8
  end

  p result.join()
end

i = 1

loop do 
  break if result.size == 8
  spawn compute(batch_channel, channel, input, i, batch_size)

  if i % batch_size == 0
    batch_channel.receive
  end

  i += 1
end