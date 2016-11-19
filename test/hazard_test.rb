require 'test_helper'

class HazardTest < Minitest::Test

  def test_dices
    Kernel.stubs( :rand ).returns( 6 )

    assert_equal 6, Hazard.d6

    assert_equal 12, Hazard.r2d6
    assert_equal 12, Hazard._2d6

    assert_equal RolledDices.new( [ 6, 6 ] ), Hazard.s2d6
  end

end
