# This class represents the result of a roll, for people that need to work wit dice details.
#
# @author Cédric ZUGER
class RolledDice

  attr_reader :result, :rolls

  # Create a RolledDice object
  #
  # @param rolls [Array] an array of integer containing the dice rolls.
  def initialize( rolls )
    @rolls = rolls
    @result = rolls.reduce(:+)
  end

  # Compare two rolls
  #
  # @param rolled_dice [RolledDice] the other RolledDice to compare
  #
  # @return [Boolean] the result of the comparison
  def ==( rolled_dice )
    @rolls == rolled_dice.rolls && @result == rolled_dice.result
  end

end