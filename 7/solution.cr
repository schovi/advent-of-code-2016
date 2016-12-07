require "./shared"

ips = File.read_lines(File.join(__DIR__, "input")).map(&.strip)

class String
  def is_abba
    size == 4 && char_at(0) != char_at(1) && self == reverse
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

def is_valid_ipv7(ip : String)
  tokens = tokenize_ip(ip)

  is_valid = false
  inside_brackets = false
  tokens.each do |(token_type, text)|
    case token_type
    when :open_bracket
      inside_brackets = true
    when :close_bracket
      inside_brackets = false
    when :text
      has_abba = text.not_nil!.slices(4).find(&.is_abba)
      
      if has_abba
        if inside_brackets
          is_valid = false
          break
        end

        is_valid = true
      end
    else
      raise "Wrong token #{token_type}"
    end
  end

  return is_valid
end

result = ips.reduce(0) do |counter, ip|
  is_valid_ipv7(ip) ? counter + 1 : counter 
end

p result