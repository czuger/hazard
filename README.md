# Hazard

[![Gem Version](https://badge.fury.io/rb/hazard.svg)](https://badge.fury.io/rb/hazard)
[![Build Status](https://travis-ci.org/czuger/hazard.svg?branch=master)](https://travis-ci.org/czuger/hazard)
[![Code Climate](https://codeclimate.com/github/czuger/hazard/badges/gpa.svg)](https://codeclimate.com/github/czuger/hazard)
[![Test Coverage](https://codeclimate.com/github/czuger/hazard/badges/coverage.svg)](https://codeclimate.com/github/czuger/hazard/coverage)

Hazard is a very simple dice library for ruby that allows you to : 
* Roll dice and get the sum
* Roll dice and work with the detail
* Random pick elements from weighted lists

1. [Installation](#installation)
1. [Basic Usage](#basic-usage)
    1. [Roll a simple die](#roll-a-simple-die)
    1. [Roll multiple dice](#roll-multiple-dice)
1. [Advanced Usage](#advanced-usage)
    1. [Roll dice and get the details](#roll-dice-and-get-the-details)
    1. [Roll dice from string input](#roll-dice-from-string-input)    
    1. [Some real cases](#some-real-cases)
1. [Weighted Tables](#weighted-tables)
    1. [If you have the weights](#if-you-have-the-weights)
    1. [If you don't have the weights (or are to lazy to get them)](#if-you-dont-have-the-weights-or-are-to-lazy-to-get-them)
    1. [Saving and loading](#saving-and-loading)    
    
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hazard', '~> 1.2.0'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hazard
    
If needed :

    $ require 'hazard'  

## Basic Usage

### Roll a simple die

    >> Hazard.d<n>        # where n is an number
    => Roll a n-sided die

Examples : 

    >> Hazard.d6
    => 2
    
    >> Hazard.d8
    => 4
     
    >> Hazard.d42
    => 38
     
    
### Roll multiple dice

    >> Hazard.r<m>d<n>    # where m and n are numbers
    => Roll m n-sided dice and return the sum
    
    # You can also use
    >> Hazard.m<m>d<n>    # where m and n are numbers       
    >> Hazard.d<m>d<n>    # where m and n are numbers

Examples : 
   
    >> Hazard.r2d6
    => 4
     
    >> Hazard.r4d8
    => 12
     
    >> Hazard.r48d42
    => 356
    
    >> Hazard.m2d6
    => 6    
     
    >> Hazard.d2d6
    => 8      
    
## Advanced Usage
        
### Roll dice and get the details

    >> Hazard.s<m>d<n>    # where m and n are numbers
    => Roll m n-sided dice and return a RolledDice object

Examples : 
         
    >> Hazard.s2d6.rolls
    => [1, 6]     
          
    >> Hazard.s2d6.result
    => 3
    
    # Caution, each time you call Hazard it will reroll the dice
    # If you want to work on result and rolls, save them in a variable    
    >> roll = Hazard.s2d6
    
    >> roll.rolls
    => [1, 6]
    
    >> roll.result
    => 7
    
    # Under the hood
    >> Hazard.s2d6
    => #<RolledDice:0x007f62e55a0010 @rolls=[1, 6], @result=7>
    
### Roll dice from string input

    >> Hazard.from_string( 's<m>d<n>' )    # where m and n are numbers
    => Roll m n-sided dice and return a RolledDice object

Examples : 
         
    >> Hazard.from_string( 'r2d6' )
    => 3     
        
### Some real cases
         
Assuming you are playing DD Next
    
    # You may want to roll 2 d20 dice with advantage (take the greatest)
    # This will rolls 2 d20, get the rolls and get the best of them
    >> Hazard.s2d20.rolls.max 
    => 19
    
    # Obviously a disadvantage is
    >> Hazard.s2d20.rolls.min
    => 13
    
    # Maybe you want to roll with an advantage and make the check (because you are as lazy as me)
    >> Hazard.s2d20.rolls.max > 12
    => true or false
    
    # Should you have the Elemental Adept feat, which mean that you treat all 1 as 2
    # If you cast a fireball, this will do the trick : 
    >> Hazard.s8d6.rolls.map{ |d| d == 1 ? 2 : d }.reduce(:+)
    => 24   
        
## Weighted Tables

Weighted tables are object that allow to get weighted random.
 
### If you have the weights

    >> wt = WeightedTable.from_weighted_table( [ <weight1>, <object1> ], [ <weight2>, <object2> ], ... ]
    # Create a weighted table storing objects according to theire weights
    
    >> wt.sample
    # Return weighted random object
    
Examples : 

    >> wt = WeightedTable.new.from_weighted_table( [ 2, :foo ], [ 1, :bar ] ]
    >> wt.sample
    # This ensure that you will get 66% foo and 33% bar
    
    
### If you don't have the weights (or are to lazy to get them)
    
    >> wt = WeightedTable.from_flat_table( <object1>, <object1>, <object2>, ... ]
    # Create a weighted table storing objects computing the weight of the objects according to theire occurences
    
    >> wt.sample
    # Return weighted random object
        
Examples : 
        
    >> wt = WeightedTable.new.from_flat_table( :foo, :foo, :bar ]
    >> wt.sample
    # This ensure that you will get 66% foo and 33% bar
               
### Saving and loading
    
    # You can save your builded table for future usage
    >> wt.to_file( filename )
    
    # And load it
    >> wt = WeightedTable.from_file( filename )   
                                      
## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/czuger/hazard. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

