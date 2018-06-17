class Jzon
  def initialize(rson_hash)
    rson_hash.each do |key, value|
      value = Jzon.new(value) if value.is_a? Hash
      instance_variable_set("@#{key}", value)
      self.class.send(:attr_accessor, key)
    end
  end

  def self.ify
    Jzon.new yield
  end
end

jzon = Jzon.ify do
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

puts jzon.inspect
puts
puts jzon.obj.foo.bar
