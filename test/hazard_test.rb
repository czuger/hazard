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


end
