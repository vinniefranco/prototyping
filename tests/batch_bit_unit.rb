describe BatchBit do
  it 'returns reserved batch with' do
    batch = BatchBit.new name: '1', seats: 0b0000, batch_size: 4

    batch.reserve(2).reserved?.must_equal true
  end

  it 'ors the batch bit with the new reservations' do
    batch = BatchBit.new name: '1', seats: 0b0000, batch_size: 4

    batch.reserve(2).batch_bit.must_equal '0011'
  end

  it 'returns false when quantity is bigger than batch size' do
    batch = BatchBit.new name: '1', seats: 0b00, batch_size: 2

    batch.reserve(3).must_equal false
  end

  it 'returns true when bookable bits are a few shifts over' do
    batch = BatchBit.new name: '1', seats: 0b00101, batch_size: 5

    batch.reserve(2).matched_indices.must_equal [0,1]
  end

  it 'ors the batch bit with shifted reservation bits' do
    batch = BatchBit.new name: '1', seats: 0b00101, batch_size: 5

    batch.reserve(2).batch_bit.must_equal '11101'
  end

  it 'returns the correct indexes' do
    batch = BatchBit.new name: '1', seats: 0b1010010001, batch_size: 10

    batch.reserve(3).matched_indices.must_equal [6, 7, 8]
  end

  it 'returns false when quantity is out of bounds' do
    batch = BatchBit.new name: '1', seats: 0b00101, batch_size: 5

    batch.reserve(3).must_equal false
  end
end
