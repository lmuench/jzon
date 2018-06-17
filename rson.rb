class Rson
  def initialize(rson_hash)
    rson_hash.each do |key, value|
      instance_variable_set("@#{key}", value)
      self.class.send(:attr_accessor, key)
    end
  end

  def self.ify
    Rson.new yield
  end
end

rson = Rson.ify do
  {
    str: 'string',
    arr: [
      one: 'foo',
      two: 'bar'
    ]
  }
end

puts rson.inspect
puts
puts rson.str
puts rson.arr[0]
