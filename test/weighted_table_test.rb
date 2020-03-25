require 'test_helper'

class HazardTest < Test::Unit::TestCase

	def test_empty_table
		assert_raises do
			WeightedTable.from_weighted_table []
		end
		assert_raises do
			WeightedTable.from_flat_table []
		end
	end

	def test_one_element_table
		assert_equal :foo, WeightedTable.from_weighted_table( [ [ 3, :foo ] ] ).sample
		assert_equal :foo, WeightedTable.from_flat_table(  [ :foo, :foo, :foo ] ).sample
	end

	def test_two_element_table
		Kernel.stubs( :rand ).returns( 0 )
		assert_raises do
			WeightedTable.from_weighted_table []
		end
		assert_raises do
			WeightedTable.from_flat_table []
		end

		Kernel.stubs( :rand ).returns( 0 )
		assert_equal :foo, WeightedTable.from_weighted_table( [ [ 3, :foo ], [ 1, :bar ] ] ).sample
		assert_equal :foo, WeightedTable.from_flat_table(  [ :foo, :foo, :foo, :bar ] ).sample
		Kernel.stubs( :rand ).returns( 1 )
		assert_equal :foo, WeightedTable.from_weighted_table( [ [ 3, :foo ], [ 1, :bar ] ] ).sample
		assert_equal :foo, WeightedTable.from_flat_table(  [ :foo, :foo, :foo, :bar ] ).sample
		Kernel.stubs( :rand ).returns( 2 )
		assert_equal :foo, WeightedTable.from_weighted_table( [ [ 3, :foo ], [ 1, :bar ] ] ).sample
		assert_equal :foo, WeightedTable.from_flat_table(  [ :foo, :foo, :foo, :bar ] ).sample
		Kernel.stubs( :rand ).returns( 3 )
		assert_equal :bar, WeightedTable.from_weighted_table( [ [ 3, :foo ], [ 1, :bar ] ] ).sample
		assert_equal :bar, WeightedTable.from_flat_table(  [ :foo, :foo, :foo, :bar ] ).sample

		Kernel.stubs( :rand ).returns( 4 )
		assert_raises 'Rand not in key range' do
			WeightedTable.from_weighted_table []
		end
		assert_raises 'Rand not in key range' do
			WeightedTable.from_flat_table []
		end
	end

	def test_three_element_table

		Kernel.stubs( :rand ).returns( 0 )
		assert_equal :foo, WeightedTable.from_weighted_table( [ [ 3, :foo ], [ 1, :bar ], [ 1, :foobar ] ] ).sample
		assert_equal :foo, WeightedTable.from_flat_table(  [ :foo, :foo, :foo, :bar, :foobar ] ).sample

		Kernel.stubs( :rand ).returns( 4 )
		assert_equal :foobar, WeightedTable.from_weighted_table( [ [ 3, :foo ], [ 1, :bar ], [ 1, :foobar ] ] ).sample
		assert_equal :foobar, WeightedTable.from_flat_table(  [ :foo, :foo, :foo, :bar, :foobar ] ).sample
	end

	def test_floating_points
		# 1 -> 4.5 => :foo
		# 4.5 -> 6 => :bar
		# 6 -> 7.5 => :foobar
		wt = WeightedTable.from_weighted_table( [ [ 3.5, :foo ], [ 1.5, :bar ], [ 1.5, :foobar ] ] )

		Kernel.stubs( :rand ).returns( 0.5 )
		assert_raises 'Rand not in key range' do
			WeightedTable.from_weighted_table []
		end

		Kernel.stubs( :rand ).returns( 1 )
		assert_equal :foo, wt.sample

		Kernel.stubs( :rand ).returns( 1.5 )
		assert_equal :foo, wt.sample

		Kernel.stubs( :rand ).returns( 4.5 )
		assert_equal :bar, wt.sample

		Kernel.stubs( :rand ).returns( 4.6 )
		assert_equal :bar, wt.sample

		Kernel.stubs( :rand ).returns( 6 )
		assert_equal :foobar, wt.sample

		Kernel.stubs( :rand ).returns( 6.3 )
		assert_equal :foobar, wt.sample

		Kernel.stubs( :rand ).returns( 7.1 )
		assert_raises 'Rand not in key range' do
			WeightedTable.from_weighted_table []
		end
	end

	def test_floating_point_statistics
		wt = WeightedTable.new( floating_points: true )

		tests_arrays = [
			[[ 2.3, :foo ], [ 1.6, :bar ]], [[ 6.4, :foo ], [ 8.2, :bar ]], [[ 35.7, :foo ], [ 678.9, :bar ]],
			[[ 6.4, :foo ], [ 8.7, :bar ], [ 4.1, :foobar ]], [[ 56, :foo ], [ 4.9, :bar ], [ 665.4, :foobar ]]
		]

		tests_arrays.each do |t_a|

			wt.from_weighted_table t_a
			results = Hash[t_a.map{ |_, elem| [ elem, 0 ] }]

			rounds = 100000
			1.upto(rounds).each do
				results[ wt.sample ] += 1
			end

			weights_sum = t_a.map{ |weight, elem| weight }.inject( :+ ).to_f

			t_a.each do |weight, elem|
				assert_in_delta weight/weights_sum, (results[elem].to_f/rounds), 0.01
			end
		end
	end

	def test_statistics
		tests_arrays = [
			[[ 2, :foo ], [ 1, :bar ]], [[ 6, :foo ], [ 8, :bar ]], [[ 35, :foo ], [ 678, :bar ]],
			[[ 6, :foo ], [ 8, :bar ], [ 4, :foobar ]], [[ 56, :foo ], [ 4, :bar ], [ 665, :foobar ]]
		]

		tests_arrays.each do |t_a|
			wt = WeightedTable.from_weighted_table t_a
			results = Hash[t_a.map{ |_, elem| [ elem, 0 ] }]

			rounds = 100000

			1.upto(rounds).each do
				results[ wt.sample ] += 1
			end

			weights_sum = t_a.map{ |weight, elem| weight }.inject( :+ ).to_f

			t_a.each do |weight, elem|
				assert_in_delta weight/weights_sum, (results[elem].to_f/rounds), 0.01
			end
		end
	end

	def test_save_and_load
		wt = WeightedTable.from_weighted_table [ [ 2, :foo ], [ 1, :bar ] ]
		wt.to_file( 'wt.yaml' )
		wt = nil
		wt = WeightedTable.from_file( 'wt.yaml' )
		Kernel.stubs( :rand ).returns( 1 )
		assert_equal :foo, wt.sample
		assert_equal :foo, wt.sample
		`rm wt.yaml`
	end

	def test_out_of_range
		Kernel.stubs( :rand ).returns( 99 )
		assert_raises do
			WeightedTable.from_weighted_table( [ [ 3, :foo ], [ 1, :bar ], [ 1, :foobar ] ] ).sample
		end
	end
end
