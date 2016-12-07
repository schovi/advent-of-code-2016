class String
  def slices(by : Int)
    result = [] of String

    0.upto(size - by) do |i|
      result.push(self[i..(i + by - 1)])
    end

    result
  end
end

def tokenize_ip(ip : String)
  tokens = [{:text, ""}] of Tuple(Symbol, String?)

  ip.each_char do |char|
    if char == '['
      tokens.push({:open_bracket, nil})
      tokens.push({:text, ""})
    elsif char == ']'
      tokens.push({:close_bracket, nil})
      tokens.push({:text, ""})
    else
      token_type, text = tokens.last

      tokens[-1] = {token_type, String.build {|s| s << text << char}}
    end
  end

  tokens
end