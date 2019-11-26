require 'yaml'

# This class contains objects and associate weights to them. So that you can sample the object according to their weights.
#
# @author Cédric ZUGER
class WeightedTable

  BASE_WEIGHT = 0

  # Initialize a WeightedTable
  # setting floating_points to true indicate that you will work with floating points rather than integers.
  def initialize( floating_points: false )
    @weights = []
    @max_weight = BASE_WEIGHT
    @floating_points = floating_points
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

    # We may call this method many time for an existing object, so we must clear it
    @weights.clear

    base = BASE_WEIGHT
    w = nil

    table.each do |weight, data|
      w = base + weight
      @weights << [base, w, data]
      base = w
    end

    @max_weight = w

    # p @weights, @max_weight

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

    # ... means that @max_weight is excluded
    if @floating_points
      r = Kernel.rand( 0.0...@max_weight.to_f )
    else
      r = Kernel.rand( 0...@max_weight )
    end

    # p r

    @weights.each do |base_weight, max_weight, data|
      return data if r >= base_weight && r < max_weight
    end

    raise 'Rand not in key range'
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