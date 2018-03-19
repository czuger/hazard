require_relative 'rolled_dice'

class Hazard

  def self.method_missing( method_name )

    # Transform the method_name to string
    method_name = method_name.to_s

    # Parse the method name to get how many dice and what size of dice was required
    dice_match = method_name.to_s.match( /(d|r|m|s)?(\d*)d(\d+)/ )
    # Raise an error if match fail
    raise "Method mising : #{method_name}" unless dice_match

    # Get the roll type
    roll_type = dice_match[1]
    splited_result = true if roll_type == 's'

    # Get the dice amount
    dice_amount = dice_match[2].to_i
    # If no amount is given then the amount is 1
    dice_amount = 1 if dice_amount == 0
    # Get the type of dice
    dice_type = dice_match[3].to_i

    # Rolls the dice
    rolls = ( 1..dice_amount ).map{ Kernel.rand( 1..dice_type ) }

    # Unless splitted_result was requested, return the sum of the rolled dice
    return rolls.reduce(:+) unless splited_result

    # Return a RolledDice otherwise
    RolledDice.new( rolls )

  end

end
