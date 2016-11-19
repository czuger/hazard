require 'test_helper'

class HazardTest < Minitest::Test

  def test_that_it_has_a_version_number
    refute_nil ::Hazard::VERSION
  end

  def test_it_does_something_useful
    assert false
  end

  def test_dices
    Kernel.stubs( :rand ).returns( 6 )

    assert_equal 6, Hazard.d6

    assert_equal 12, Hazard.r2d6
    assert_equal 12, Hazard._2d6

    r = { result: 12, rolls: [ 6, 6 ] }
    assert_equal r, Hazard.s2d6
  end

end
