class Rson
  def initialize(rson_hash)
    rson_hash.each do |key, value|
      value = Rson.new(value) if value.is_a? Hash
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
    ],
    obj: {
      foo: {
        bar: 'success'
      }
    }
  }
end

# rson = Rson.ify { { str: 'string', num: 1 } }

puts rson.inspect
puts
puts rson.obj.foo.bar
