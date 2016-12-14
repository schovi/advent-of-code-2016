input = File.read(File.join(__dir__, "input"))

class Input
  def initialize(input, level = 1)
    @level = level
    if level > 1
      p input
    end
    @input = input
    @cursor = 0
  end

  def decompress
    result = StringIO.new

    # TODO detect end of input
    while @cursor < @input.length
      p @level

      wait_for_compression_mark(result)

      compression_length = get_compression_length
      
      if compression_length > 0
        compression_multiplier = get_compression_multiplier

        data = get_compressed_data(compression_length)

        if data.include?('(')
          data = Input.new(data, @level + 1).decompress
          # Try to clean after 
          GC.start(full_mark: true, immediate_sweep: true);
        end

        result << data * compression_multiplier
      end
    end
    
    result.string
  end    

  def wait_for_compression_mark(result)
    result << take_chars_until_or_end { |char| char == '(' }
  end

  def get_compression_length
    length = take_chars_until_or_end { |char| char == 'x' }

    if !length || length.length == 0
      return 0
    end

    length = length.to_i
  end

  def get_compression_multiplier
    multiplier = take_chars_until_or_end { |char| char == ')' }
    if !multiplier || multiplier.length == 0
      return 0
    end

    multiplier = multiplier.to_i
  end

  def get_compressed_data(length)
    data = @input[@cursor...@cursor + length]
    @cursor += length
    data
  end

  def take_chars_until_or_end
    before = ""
    char = nil

    loop do
      return before unless @cursor < @input.size

      char = @input[@cursor]
      
      @cursor += 1

      if yield(char)
        return before 
      end
    
      before += char
    end
  end
end

data = Input.new(input)

p data.decompress.length