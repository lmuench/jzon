require_relative '../lib/jzon'
require 'rspec'

# rubocop:disable Metrics/BlockLength

RSpec.describe Jzon do
  describe '#ify' do
    it 'returns a Jzon object created from a hash passed as a block' do
      jzon = Jzon.ify do
        {
          m1: 'object->string',
          m2: [
            'object->array->string',
            {
              m1: 'object->array->object->string',
              m2: [
                'object->array->object->array->string'
              ]
            }
          ],
          m3: {
            m1: 'object->object->string',
            m2: {
              m1: 'object->object->object->string'
            }
          }
        }
      end
      expect(jzon.m1).to eq('object->string')
      expect(jzon.m2[0]).to eq('object->array->string')
      expect(jzon.m2[1].m1).to eq('object->array->object->string')
      expect(jzon.m2[1].m2[0]).to eq('object->array->object->array->string')
      expect(jzon.m3.m1).to eq('object->object->string')
      expect(jzon.m3.m2.m1).to eq('object->object->object->string')
    end
  end
end

# rubocop:enable Metrics/BlockLength
