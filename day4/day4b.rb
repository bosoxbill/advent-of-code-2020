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

  def initialize(opts = {})
    clean_opts = opts.slice(*VALID_ATTRS)
    clean_opts.each do |(attr, value)|
      self.instance_variable_set "@#{attr}", value 
    end
  end

  def valid?
    valid_fields = 0
    REQUIRED_ATTRS.each do |attr|
      ivar = instance_variable_get("@#{attr}")
      validity_method = "#{attr}_valid?"
      valid = send(validity_method)
      return false unless valid
    end
    return true
  end

  def passport_id_valid?
    self.passport_id &&
      self.passport_id.chars.count == 9
  end

  def country_id_valid?
    true
  end

  def birth_year_valid?
    self.birth_year&&
      self.birth_year.chars.count == 4 &&
      (1920..2002).include?(birth_year.to_i)
  end

  def issue_year_valid?
    self.issue_year &&
      self.issue_year.chars.count == 4 &&
      (2010..2020).include?(issue_year.to_i)
  end

  def expiration_year_valid?
    self.birth_year &&
      self.birth_year.chars.count == 4 &&
      (2020..2030).include?(expiration_year.to_i)
  end

  def height_valid?
    return false if self.height.nil?
    /(?<measurement>\d{2,3})(?<units>[a-z]{2})/i =~ self.height
    case units
      when 'cm'
        return (150..193).include? measurement.to_i
      when 'in'
        return (59..76).include? measurement.to_i      
      else
        return false
    end
  end

  def hair_color_valid?
    #a # followed by exactly six characters 0-9 or a-f.
    return false if self.hair_color.nil?
    /#([0-9]|[a-f]){6}/i =~ self.hair_color
  end

  def eye_color_valid?
    %w(amb blu brn gry grn hzl oth).include?(self.eye_color)
  end

  def height_valid?
    /(?<measurement>\d{2,3})(?<units>[a-z]{2})/i =~ self.height
    case units
      when 'cm'
        return (150..193).include? measurement.to_i
      when 'in'
        return (59..76).include? measurement.to_i      
      else
        return false
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
  #ids.each {|id| puts "#{id.inspect} - #{id.valid?}"}
  valid = ids.select(&:valid?)
  return valid.count
end

puts do_it()
