# Hazard

[![Gem Version](https://badge.fury.io/rb/hazard.svg)](https://badge.fury.io/rb/hazard)
[![Code Climate](https://codeclimate.com/github/czuger/hazard/badges/gpa.svg)](https://codeclimate.com/github/czuger/hazard)

Hazard is a very simple dices library for ruby (see [usage](#usage)).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hazard'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hazard
    
If needed :

    $ require 'hazard'  

## Usage

Roll a simple dice

    >> Hazard.d<n>        # where n is an number
    => Roll a n-sided dice

Examples : 

    >> Hazard.d6
    => 2
    
    Hazard.d8
    => 4
     
    Hazard.d42
    => 38
     
    
Roll multiple dices

    >> Hazard.r<m>d<n>    # where m and n are numbers
    => Roll m n-sided dices and return the sum

Examples : 
   
    Hazard.r2d6
     => 4
     
    Hazard.r4d8
     => 12
     
    Hazard.r48d42
     => 356
         
         
Roll dices but get the detail

    >> Hazard.s<m>d<n>    # where m and n are numbers
    => Roll m n-sided dices and return a RolledDices object

Examples : 
         
    >> Hazard.s2d6.rolls
    => [1, 6]     
          
    >> Hazard.s2d6.result
    => 7
    
    # Under the hood
    >> Hazard.s2d6
    => #<RolledDices:0x007f62e55a0010 @rolls=[1, 6], @result=7>
    
Some real cases
         
    # Assuming you are playing DD Next
    
    # You may want to roll 2 d20 dices with advantage (take the greatest)
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
    
    >> Hazard.s6d6.rolls.map{ |d| d == 1 ? 2 : d }.reduce(:+)
    => 13
                    
    
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/czuger/hazard. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

