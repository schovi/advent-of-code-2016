require "./shared"

ips = File.read_lines(File.join(__DIR__, "input")).map(&.strip)

class String
  def is_aba
    size == 3 && char_at(0) != char_at(1) && self == reverse
  end
end

def is_valid_ipv7(ip : String)
  tokens = tokenize_ip(ip)

  abas = Set(String).new
  babs = Set(String).new

  inside_brackets = false
  tokens.each do |(token_type, text)|
    case token_type
    when :open_bracket
      inside_brackets = true
    when :close_bracket
      inside_brackets = false
    when :text
      matched_abas = text.not_nil!.slices(3).select(&.is_aba)
      
      if inside_brackets
        babs.merge(matched_abas)
      else
        abas.merge(matched_abas)
      end
    else
      raise "Wrong token #{token_type}"
    end
  end

  inverzed_abas = Set.new(abas.map do |aba|
    String.build {|s| s << aba.char_at(1) << aba.char_at(0) << aba.char_at(1)}
  end)

  inverzed_abas.intersects?(babs)
end

result = ips.reduce(0) do |counter, ip|
  is_valid_ipv7(ip) ? counter + 1 : counter 
end

p result