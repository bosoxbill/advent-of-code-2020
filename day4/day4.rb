class Identification
  SHORTHAND_TO_ATTRS = {
    pid: :passport_id,
    cid: :country_id,
    byr: :birth_year,
    iyr: :issue_year,
    eyr: :expiration_year,
    hgt: :height,
    hcl: :hair_color,
    ecl: :eye_color
  }
  VALID_ATTRS = SHORTHAND_TO_ATTRS.values
  REQUIRED_ATTRS = VALID_ATTRS - [:country_id]
  attr_accessor *VALID_ATTRS

  def initialize(opts ={})
    clean_opts = opts.slice(VALID_ATTRS)
    VALID_ATTRS.each do |(attr, value)|
      send "#{attr}=", value
    end
  end

  def valid?
    valid_fields = 0
    REQUIRED_ATTRS.each do |attr|
      ivar = instance_variable_get("@#{attr}")
      return false if ivar.nil?
    end
    return true
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
        identifications << id
        id = Identification.new
        next
      end

      key_value_pairs.each do |kvp|
        key, value = kvp.split(':')
        ivar_name = Identification::SHORTHAND_TO_ATTRS[key.to_sym]
        id.send("#{ivar_name}=", value)
      end
    end
  end
  identifications << id
  return identifications
end


def do_it  
  ids = read_input
  valid = ids.select(&:valid?)
  return valid.count
end

puts do_it()
