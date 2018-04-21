require 'test_helper'

class HazardTest < Minitest::Test

  def test_empty_table
    assert_raises do
      WeightedTable.new.from_weighted_table []
    end
    assert_raises do
      WeightedTable.new.from_flat_table []
    end
  end

  def test_one_element_table
    assert_equal :foo, WeightedTable.new.from_weighted_table( [ [ 3, :foo ] ] ).sample
    assert_equal :foo, WeightedTable.new.from_flat_table(  [ :foo, :foo, :foo ] ).sample
  end

  def test_two_element_table
    Kernel.stubs( :rand ).returns( 0 )
    assert_raises do
      WeightedTable.new.from_weighted_table []
    end
    assert_raises do
      WeightedTable.new.from_flat_table []
    end

    Kernel.stubs( :rand ).returns( 1 )
    assert_equal :foo, WeightedTable.new.from_weighted_table( [ [ 3, :foo ], [ 1, :bar ] ] ).sample
    assert_equal :foo, WeightedTable.new.from_flat_table(  [ :foo, :foo, :foo, :bar ] ).sample
    Kernel.stubs( :rand ).returns( 2 )
    assert_equal :foo, WeightedTable.new.from_weighted_table( [ [ 3, :foo ], [ 1, :bar ] ] ).sample
    assert_equal :foo, WeightedTable.new.from_flat_table(  [ :foo, :foo, :foo, :bar ] ).sample
    Kernel.stubs( :rand ).returns( 3 )
    assert_equal :foo, WeightedTable.new.from_weighted_table( [ [ 3, :foo ], [ 1, :bar ] ] ).sample
    assert_equal :foo, WeightedTable.new.from_flat_table(  [ :foo, :foo, :foo, :bar ] ).sample
    Kernel.stubs( :rand ).returns( 4 )
    assert_equal :bar, WeightedTable.new.from_weighted_table( [ [ 3, :foo ], [ 1, :bar ] ] ).sample
    assert_equal :bar, WeightedTable.new.from_flat_table(  [ :foo, :foo, :foo, :bar ] ).sample

    Kernel.stubs( :rand ).returns( 5 )
    assert_raises do
      WeightedTable.new.from_weighted_table []
    end
    assert_raises do
      WeightedTable.new.from_flat_table []
    end
  end

  def test_statistics

    wt = WeightedTable.new.from_weighted_table [ [ 2, :foo ], [ 1, :bar ] ]
    results = { foo: 0, bar: 0 }
    1.upto(100).each do
      results[ wt.sample ] += 1
    end

    assert_in_delta 0.33, (results[:bar]*0.01), 0.1
    assert_in_delta 0.66, (results[:foo]*0.01), 0.1
  end

end
