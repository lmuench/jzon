require 'json'

class Jzon
  def initialize(jzon_hash)
    jzon_hash.each do |key, value|
      if value.is_a? Hash
        value = Jzon.new(value)
      elsif value.is_a? Array
        value = Jzon.initialize_array(value)
      end

      instance_variable_set("@#{key}", value)
      self.class.send(:attr_accessor, key)
    end
  end

  def self.initialize_array(jzon_array)
    jzon_array.map do |item|
      if item.is_a? Hash
        Jzon.new(item)
      elsif item.is_a? Array
        Jzon.initialize_array(item)
      else
        item
      end
    end
  end

  def self.ify
    block = yield
    if block.is_a? Hash
      Jzon.new(block)
    elsif block.is_a? Array
      Jzon.initialize_array(block)
    else
      block
    end
  end

  def stringify(pretty = false)
    hash = hashify
    pretty ? JSON.pretty_generate(hash) : JSON.generate(hash)
  end

  def hashify
    hash = {}
    instance_variables.each do |key|
      value = instance_variable_get(key)
      if value.is_a? Jzon
        value = value.hashify
      elsif value.is_a? Array
        value = hashify_array(value)
      end
      hash[key[1..-1]] = value
    end
    hash
  end

  def hashify_array(jzon_array)
    jzon_array.map do |item|
      if item.is_a? Jzon
        item.hashify
      elsif item.is_a? Array
        hashify_array(item)
      else
        item
      end
    end
  end
end
