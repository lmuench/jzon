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

    it 'returns a Jzon array created from a array passed as a block' do
      jzon = Jzon.ify do
        [
          'array->string',
          [
            'array->array->string',
            {
              m1: 'array->array->object->string',
              m2: [
                'array->array->object->array->string'
              ]
            }
          ],
          {
            m1: 'array->object->string',
            m2: {
              m1: 'array->object->object->string'
            }
          }
        ]
      end
      expect(jzon[0]).to eq('array->string')
      expect(jzon[1][0]).to eq('array->array->string')
      expect(jzon[1][1].m1).to eq('array->array->object->string')
      expect(jzon[1][1].m2[0]).to eq('array->array->object->array->string')
      expect(jzon[2].m1).to eq('array->object->string')
      expect(jzon[2].m2.m1).to eq('array->object->object->string')
    end

    it 'returns the value passed as a block if it is neiter hash or array' do
      jzon = Jzon.ify do
        'string'
      end
      expect(jzon).to eq('string')
    end
  end
end

# rubocop:enable Metrics/BlockLength
