class Jzon
  def initialize(jzon_hash)
    jzon_hash.each do |key, value|
      if value.is_a? Hash
        value = Jzon.new(value)
      elsif value.is_a? Array
        value = handle_array(value)
      end

      instance_variable_set("@#{key}", value)
      self.class.send(:attr_accessor, key)
    end
  end

  def handle_array(value)
    value.map do |item|
      if item.is_a? Hash
        Jzon.new(item)
      elsif item.is_a? Array
        handle_array(item)
      else
        item
      end
    end
  end

  def self.ify
    Jzon.new yield
  end
end
