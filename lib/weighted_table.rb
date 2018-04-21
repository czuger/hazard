require 'yaml'

class WeightedTable

  BASE_WEIGHT = 1

  def initialize
    @weights = {}
    @max_weight = BASE_WEIGHT
  end

  # Load a WeightedTable with data
  # Data format must be : [ [ weight, data ], [ weight, data ], ... ]
  # Example : [ [ 2, :foo ], [ 1, :bar ] ]
  #
  # @return [WeightedTable] the current WeightedTable
  def self.from_weighted_table( table )
    WeightedTable.new.from_weighted_table( table )
  end

  # Load a WeightedTable with data
  # Data format must be : [ [ weight, data ], [ weight, data ], ... ]
  # Example : [ [ 2, :foo ], [ 1, :bar ] ]
  #
  # @return [WeightedTable] the current WeightedTable
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

  # Load a WeightedTable with data
  # Data format must be : [ data, data, data ]
  # Example : [ :foo, :foo, :bar ]
  #
  # @return [WeightedTable] the current WeightedTable
  def self.from_flat_table( table )
    from_weighted_table( table.group_by{ |e| e }.map{ |k, v| [ v.count, k ] } )
  end

  # Return a random item from a WeightedTable
  #
  # @return [Object] a random object given at the building of the table.
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

  # Load a WeightedTable with data
  # Data format must be : [ data, data, data ]
  # Example : [ :foo, :foo, :bar ]
  #
  # @return [WeightedTable] the current WeightedTable
  def from_flat_table( table )
    from_weighted_table( table.group_by{ |e| e }.map{ |k, v| [ v.count, k ] } )
  end

  # Save the table to a file
  # @param filename [String] the filename where to save the table
  def to_file( filename )
    File.open( filename, 'w' ) do |f|
      f.write( to_yaml )
    end
  end

  # Read the table from a file
  # @param filename [String] the filename from which to read the table
  def self.from_file( filename )
    YAML.load_file( filename )
  end

end