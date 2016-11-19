require_relative 'rolled_dices'

class Hazard

  def self.method_missing( method_name )

    # Transform the method_name to string
    method_name = method_name.to_s

    # If first character is 's'
    if method_name[0] == 's'
      method_name = method_name[1..-1]
      # Then we will return a splitted result
      splitted_result = true
    end

    # Parse the method name to get how many dices and what size of dices was required
    dices_match = method_name.to_s.match( /(\d*)d(\d+)/ )
    # Raise an error if match fail
    raise "Method mising : #{method_name}" unless dices_match

    # Get the dices amount
    dices_amount = dices_match[1].to_i
    # If no amount is given then the amount is 1
    dices_amount = 1 if dices_amount == 0
    # Get the type of dices
    dice_type = dices_match[2].to_i

    # Rolls the dices
    rolls = (1..dices_amount).map{ Kernel.rand( 1..dice_type ) }

    # Unless splitted_result was requested, return the sum of the rolled dices
    return rolls.reduce(:+) unless splitted_result

    # Return a RolledDices otherwise
    RolledDices.new( rolls )

  end

end