require_relative 'rolled_dice'
require_relative 'weighted_table'

# This class roll the dice.
#
# @author Cédric ZUGER
class Hazard

  DICE_NAME_REGEXP = /(d|r|m|s)?(\d*)d(\d+)/.freeze

  # Regular entry point. This is where you will go when you call Hazard.d6 for instance.
  #
  # @param method_name [String] the description of the dice. See help for detail.
  #
  # @return [Object] if detail has been asked, it will return a [RolledDice] object, otherwise it will return an [Integer] containing the sum of the dice.
  def self.method_missing( method_name )
    method_name = method_name.to_s

    if method_name =~ DICE_NAME_REGEXP
      roll_dice( method_name )
    else
      super
    end
  end

  # From string entry point, in case you have your dice description in a database for instance.
  #
  # @param dice_string [String] the description of the dice. See help for detail.
  #
  # @return [Object] if detail has been asked, it will return a [RolledDice] object, otherwise it will return an [Integer] containing the sum of the dice.
  def self.from_string( dice_string )
    roll_dice( dice_string )
  end

  # Hook the method_missing
  def self.respond_to_missing?(method_name, include_private = false)
    method_name.to_s =~ DICE_NAME_REGEXP || super
  end

  # Roll a dice and return true if you rolled the highest number
  #
  # @param dice [Integer] the dice you want to roll.
  #
  # @return [Boolean] true if you scored the highest number, false otherwise.
  def self.lucky?( dice )
    roll_dice( "d#{dice}" ) == dice
  end

  private

  # Roll dice according to method name
  #
  # @param method_name [String] the description of the dice. See help for detail.
  #
  # @return [Object] if detail has been asked, it will return a [RolledDice] object, otherwise it will return an [Integer] containing the sum of the dice.
  def self.roll_dice( method_name )
    # Parse the method name to get how many dice and what size of dice was required
    dice_match = method_name.to_s.match DICE_NAME_REGEXP

    # Get the roll type
    roll_type = dice_match[1]
    splitted_result = true if roll_type == 's'

    # Get the type of dice
    dice_type = dice_match[3].to_i

    # Rolls the dice
    rolls = ( 1..dice_amount(dice_match) ).map{ Kernel.rand( 1..dice_type ) }

    # Unless splitted_result was requested, return the sum of the rolled dice
    return rolls.reduce(:+) unless splitted_result

    # Return a RolledDice otherwise
    RolledDice.new( rolls )
  end

  def self.dice_amount( dice_match )
    # Get the dice amount
    dice_amount = dice_match[2].to_i
    # If no amount is given then the amount is 1
    dice_amount.zero? ? 1 : dice_amount
  end

end
