class Identification
  ATTRS = [:pid, :cid, :byr, :iyr, :eyr, :hgt, :hcl, :ecl]
  OPTIONAL_ATTRS = [:cid]
  attr_accessor *ATTRS

  def initialize(opts ={})
    clean_opts = opts.slice(ATTRS)
    ATTRS.each do |(attr, value)|
      instance_variable_set "@#{attr}", value
    end
  end

  def valid?
    ATTRS.each do |attr|
      next if OPTIONAL_ATTRS.include? attr
      ivar = instance_variable_get(attr)
      return false unless ivar.present?
    end
  end
end

def read_input
  valid_count = 0
  identifications = Array.new
  id = Identification.new
  File.open('input.txt', 'r') do |f|
    f.each_line do |line|
      key_value_pairs = line.split(' ')
      if key_value_pairs.empty?
        if id.valid?
          valid_count += 1
        end
        identifications << id
        id = Identification.new
        next
      end

      key_value_pairs.each do |kvp|
        key, value = kvp.split(':')
        id.send("#{key}=", value)
      end
    end
  end
  return identifications, valid_count
end


def do_it
  ids, count = read_input
  return count
end

puts do_it()
