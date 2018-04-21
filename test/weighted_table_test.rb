require 'test_helper'

class HazardTest < Minitest::Test

  def test_empty_table
    assert_raises do
      WeightedTable.from_weighted_table []
    end
    assert_raises do
      WeightedTable.from_flat_table []
    end
  end

  def test_one_element_table
    assert_equal :foo, WeightedTable.from_weighted_table( [ [ 3, :foo ] ] ).sample
    assert_equal :foo, WeightedTable.from_flat_table(  [ :foo, :foo, :foo ] ).sample
  end

  def test_two_element_table
    Kernel.stubs( :rand ).returns( 0 )
    assert_raises do
      WeightedTable.from_weighted_table []
    end
    assert_raises do
      WeightedTable.from_flat_table []
    end

    Kernel.stubs( :rand ).returns( 1 )
    assert_equal :foo, WeightedTable.from_weighted_table( [ [ 3, :foo ], [ 1, :bar ] ] ).sample
    assert_equal :foo, WeightedTable.from_flat_table(  [ :foo, :foo, :foo, :bar ] ).sample
    Kernel.stubs( :rand ).returns( 2 )
    assert_equal :foo, WeightedTable.from_weighted_table( [ [ 3, :foo ], [ 1, :bar ] ] ).sample
    assert_equal :foo, WeightedTable.from_flat_table(  [ :foo, :foo, :foo, :bar ] ).sample
    Kernel.stubs( :rand ).returns( 3 )
    assert_equal :foo, WeightedTable.from_weighted_table( [ [ 3, :foo ], [ 1, :bar ] ] ).sample
    assert_equal :foo, WeightedTable.from_flat_table(  [ :foo, :foo, :foo, :bar ] ).sample
    Kernel.stubs( :rand ).returns( 4 )
    assert_equal :bar, WeightedTable.from_weighted_table( [ [ 3, :foo ], [ 1, :bar ] ] ).sample
    assert_equal :bar, WeightedTable.from_flat_table(  [ :foo, :foo, :foo, :bar ] ).sample

    Kernel.stubs( :rand ).returns( 5 )
    assert_raises do
      WeightedTable.from_weighted_table []
    end
    assert_raises do
      WeightedTable.from_flat_table []
    end
  end

  def test_statistics

    wt = WeightedTable.from_weighted_table [ [ 2, :foo ], [ 1, :bar ] ]
    results = { foo: 0, bar: 0 }

    rounds = 1000

    1.upto(rounds).each do
      results[ wt.sample ] += 1
    end

    assert_in_delta 0.33, (results[:bar].to_f/rounds), 0.1
    assert_in_delta 0.66, (results[:foo].to_f/rounds), 0.1
  end

  def test_save_and_load
    wt = WeightedTable.from_weighted_table [ [ 2, :foo ], [ 1, :bar ] ]
    wt.to_file( 'wt.yaml' )
    wt = nil
    wt = WeightedTable.from_file( 'wt.yaml' )
    Kernel.stubs( :rand ).returns( 1 )
    assert_equal :foo, wt.sample
    assert_equal :foo, wt.sample
    `rm wt.yaml`
  end

end
