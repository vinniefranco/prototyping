class Reservator
  def initialize(sku, batch_data, seat_map)
    @sku = sku
    @seat_map = seat_map
    @batch = BatchBit.new batch_data.shift

    batch_data.inject(@batch) do |instance, data|
      instance.next_batch = BatchBit.new(data)
    end
  end

  def reserve(quantity)
    if reservation = batch.reserve(quantity)
      seat_map[reservation.name].values_at(*reservation.matched_indices)
    else
      false
    end
  end

  private

  attr_reader :batch, :seat_map
end
