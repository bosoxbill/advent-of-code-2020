h = Hash.new

File.open('input.txt', 'r') do |f|
  f.each_line do |line|
    h[line.to_i] = line.to_i
  end
end

h.keys.each do |k|
  val = 2020 - k
  if h[val]
    out = k * h[val]
    puts "Output: #{out}"
    exit
  end
end
