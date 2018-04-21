class WeightedTable

  BASE_WEIGHT = 1

  def initialize
    @weights = {}
    @max_weight = BASE_WEIGHT
  end

  def from_weighted_table( table )
    raise 'Table must contain at least one element' if table.empty?
    base = BASE_WEIGHT
    table.each do |t|
      w = base+t[0]
      base = w
      @weights[ w ] = t[1]
      @max_weight = [ @max_weight, w-1 ].max
    end
    self
  end

  def from_flat_table( table )
    from_weighted_table( table.group_by{ |e| e }.map{ |k, v| [ v.count, k ] } )
  end

  def sample
    r = Kernel.rand( 1..@max_weight )
    keys = @weights.keys.sort

    low_mark = BASE_WEIGHT

    until keys.empty?
      high_mark = keys.shift
      return @weights[high_mark] if r >= low_mark && r < high_mark
      low_mark = high_mark
    end

    raise 'Rand not in key range'
  end

end