h = Hash.new

File.open('input.txt', 'r') do |f|
  f.each_line do |line|
    h[line.to_i] = line.to_i
  end
end

h.keys.each do |k1|
  h.keys.each do |k2|
    val = 2020 - k1 - k2
    if h[val]
      out = k1 * k2 * h[val]
      puts "Output: #{out}"
      exit
    end
  end
end
