class RolledDices

  attr_reader :result, :rolls

  def initialize( rolls )
    @rolls = rolls
    @result = rolls.reduce(:+)
  end

  # Required for tests
  def ==( rolled_dices )
    @rolls == rolled_dices.rolls && @result == rolled_dices.result
  end

end