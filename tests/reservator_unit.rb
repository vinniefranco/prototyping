describe Reservator do
  it 'returns true if reserved' do
    seat_map = {
      'batch1' => [
        {section: 'A', row: '12', seat: 18},
        {section: 'A', row: '12', seat: 16},
        {section: 'A', row: '12', seat: 14},
        {section: 'A', row: '12', seat: 12},
      ],
      'batch2' => [
        {section: 'B', row: '21', seat: 14},
        {section: 'B', row: '21', seat: 13},
        {section: 'B', row: '21', seat: 12},
        {section: 'B', row: '21', seat: 11},
      ]
    }

    batch_data = [
      { name: 'batch1', seats: 0b0, batch_size: 4 },
      { name: 'batch2', seats: 0b0, batch_size: 4 },
      { name: 'batch3', seats: 0b0, batch_size: 4 },
    ]

    reservator = Reservator.new 'fart', batch_data, seat_map

    reservations = reservator.reserve(2)

    reservations.must_equal [
      {section: 'A', row: '12', seat: 14},
      {section: 'A', row: '12', seat: 12},
    ]
  end
end
