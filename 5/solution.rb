require 'digest/md5'

input = "ugkcyxxp"

i = 0

result = [] 

zeros = /^00000/

loop do
  md5 = Digest::MD5.hexdigest("#{input}#{i}")
  
  if md5.slice(zeros)
    result.push(md5[5])
    break if result.size == 8
  end

  i += 1
end

p result.join