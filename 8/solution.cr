struct Screen
  def initialize(@columns : Int32, @rows : Int32)
    @pixels = Array(Array(Bool)).new(@columns) do
      Array(Bool).new(@rows, false)
    end    
  end

  def print
    print "Screen:\n"
    @pixels.transpose.each do |columns|
      columns.each do |pixel|
        print pixel ? '#' : '.'
      end
      print "\n"
    end
  end

  def pixels_on?
    @pixels.flatten.select(&.==(true)).size
  end

  def swipe(instructions)
    instructions.each do |instruction|
      process_instruction(instruction)
    end
  end

  def on_rect(from_x, from_y, cols, rows)
    from_x.upto(from_x + cols - 1) do |x|
      from_y.upto(from_y + rows - 1) do |y|
        on(x, y)
      end
    end
  end

  def on(x, y)
    @pixels[x][y] = true
  end

  def off(x, y)
    @pixels[x][y] = false
  end

  def process_instruction(instruction)
    command, data = instruction.split(' ', 2)

    if command == "rect"
      cols, rows = data.split("x")
      run_rect(cols.to_i32, rows.to_i32)
    elsif command == "rotate"
      match = data.match(/([a-z]+)\s[a-z]=(\d+)\sby\s(\d+)/).not_nil!
      which = match[1]
      index = match[2].to_i32
      by    = match[3].to_i32

      if which == "row"
        rotate_row(index, by)
      elsif which == "column"
        rotate_column(index, by)
      end
    end
  end

  def run_rect(cols, rows)
    on_rect(0, 0, cols, rows)
  end

  def rotate_row(y, by)
    by.times do
      prev = @pixels[@columns - 1][y]
      0.upto(@columns - 1) do |x|
        temp = @pixels[x][y]
        @pixels[x][y] = prev
        prev = temp
      end

      @pixels[0][y] = prev
    end
  end

  def rotate_column(x, by)
    by.times do
      prev = @pixels[x][@rows - 1]
      0.upto(@rows - 1) do |y|
        temp = @pixels[x][y]
        @pixels[x][y] = prev
        prev = temp
      end

      @pixels[x][0] = prev
    end
  end
end

screen = Screen.new(50,6)
screen.swipe(File.read_lines(File.join(__DIR__, "input")).map(&.strip))
screen.print
p screen.pixels_on?