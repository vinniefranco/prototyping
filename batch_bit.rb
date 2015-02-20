class BatchBit
  attr_accessor :next_batch
  attr_reader :name

  def initialize(name:, seats:, batch_size:)
    @name = name
    @seats = seats
    @size = batch_size
  end

  def reserve(quantity, shift = 0)
    return check_next_batch(quantity) if impossible_reservation?(quantity, shift)

    check_bit = quantity_to_bit quantity

    if (seats & (check_bit<<shift)) == 0
      reserve_bit (check_bit<<shift)
      self
    else
      reserve(quantity, shift + 1)
    end
  end

  def matched_indices
    matched_string = bit_string(matched_bit)
    (0...matched_string.size).find_all { |idx| matched_string[idx,1] == '1' }
  end

  def batch_bit
    bit_string(seats)
  end

  def reserved?
    !!@matched_bit
  end

  private

  def check_next_batch(quantity)
    if next_batch
      next_batch.reserve(quantity)
    else
      false
    end
  end

  def reserve_bit(bit)
    @matched_bit = bit
    @seats |= bit
  end

  def impossible_reservation?(quantity, shift)
   quantity > size || shift > (size - quantity)
  end

  def quantity_to_bit(quantity)
    (2**quantity) - 1
  end

  def bit_string(bit)
    '%0*b' % [size, bit]
  end

  attr_reader :size, :seats, :matched_bit
end
