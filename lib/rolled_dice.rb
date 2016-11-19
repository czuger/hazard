class RolledDice

  attr_reader :result, :rolls

  def initialize( rolls )
    @rolls = rolls
    @result = rolls.reduce(:+)
  end

  # Required for tests
  def ==( rolled_dice )
    @rolls == rolled_dice.rolls && @result == rolled_dice.result
  end

end