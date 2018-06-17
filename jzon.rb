class Jzon
  def initialize(jzon_hash)
    jzon_hash.each do |key, value|
      value = Jzon.new(value) if value.is_a? Hash
      instance_variable_set("@#{key}", value)
      self.class.send(:attr_accessor, key)
    end
  end

  def self.ify
    Jzon.new yield
  end
end
