require 'test_helper'

class HazardTest < Minitest::Test

  def test_dice

    Kernel.stubs( :rand ).returns( 6 )

    assert_equal 6, Hazard.d6

    assert_equal 12, Hazard.r2d6
    assert_equal 12, Hazard._2d6
    assert_equal 12, Hazard.m2d6
    assert_equal 12, Hazard.d2d6
    assert_equal 18, Hazard.d3d6

    assert_equal RolledDice.new([6, 6 ] ), Hazard.s2d6

  end

  def test_dice_from_string

    Kernel.stubs( :rand ).returns( 6 )

    assert_equal 6, Hazard.from_string( 'd6' )

    assert_equal 12, Hazard.from_string( 'r2d6' )
    assert_equal 12, Hazard.from_string( '_2d6' )
    assert_equal 12, Hazard.from_string( 'm2d6' )
    assert_equal 12, Hazard.from_string( 'd2d6' )
    assert_equal 18, Hazard.from_string( 'd3d6' )

    assert_equal RolledDice.new([6, 6 ] ), Hazard.from_string( 's2d6' )

  end

  def test_lucky
    total = 0
    hits = 0

    1.upto(1000).each do
      total += 1
      hits += 1 if Hazard.lucky?( 6 )
    end

    assert_in_delta hits.to_f/total, 1.0/6, 1.0/10
  end

  def test_method_missing
    assert Hazard.respond_to?(:d6)
    refute Hazard.respond_to?(:foo)

    assert_raises do
      Hazard.foo
    end
  end


end
