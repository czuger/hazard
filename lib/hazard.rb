class Hazard

  def self.method_missing( method_name )

    method_name = method_name.to_s

    if method_name[0] == 's'
      method_name = method_name[1..-1]
      splitted_result = true
    end

    dices_match = method_name.to_s.match( /(\d*)d(\d+)/ )
    raise "Method mising : #{method_name}" unless dices_match

    dices_amount = dices_match[1].to_i
    dices_amount = 1 if dices_amount == 0
    dice_type = dices_match[2].to_i

    return (1..dices_amount).inject(0) { |sum, _| sum + Kernel.rand( 1..dice_type ) } unless splitted_result

    splitted_result_map = (1..dices_amount).map{ Kernel.rand( 1..dice_type ) }
    { result: splitted_result_map.reduce(:+), rolls: splitted_result_map }
  end

end