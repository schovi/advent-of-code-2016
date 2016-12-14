input = File.read(File.join(__DIR__, "input"))

struct Data
  def initialize(@input : String)
    @cursor = 0
  end

  def decompress
    String.build do |result|
      # TODO detect end of input
      while @cursor < @input.size
        wait_for_compression_mark(result)

        compression_length = get_compression_length
        compression_multiplier = get_compression_multiplier

        data = get_compressed_data(compression_length)

        result << data * compression_multiplier
      end    
    end    
  end

  def wait_for_compression_mark(result)
    result << take_chars_until_or_end { |char| char == '(' }
  end

  def get_compression_length
    length = take_chars_until_or_end { |char| char == 'x' }

    if !length || length.size == 0
      return 0
    end

    length = length.not_nil!.to_i32
  end

  def get_compression_multiplier
    multiplier = take_chars_until_or_end { |char| char == ')' }
    if !multiplier || multiplier.size == 0
      return 0
    end

    multiplier = multiplier.not_nil!.to_i32
  end

  def get_compressed_data(length)
    p "GET data #{length} length"
    data = @input[@cursor...@cursor + length]
    p "data = #{data}"
    @cursor += length
    p "Next cursor #{@cursor} from #{@input.size - 1}"
    data
  end

  def take_chars_until_or_end
    before = ""
    char = nil

    loop do
      return before unless @cursor < @input.size

      char = @input.char_at(@cursor)
      
      @cursor += 1

      if yield(char)
        p "MATCH '#{char}' on index #{@cursor - 1}"
        p "Next cursor #{@cursor} from #{@input.size - 1}"
        return before 
      end
    
      before += char
    end
  end
end

data = Data.new(input)

p data.decompress.size