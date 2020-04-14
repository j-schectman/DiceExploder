#!/usr/bin/env ruby
require './dice.rb'
require 'optparse'

explosions = nil
OptionParser.new do |opt|
    opt.on('-e', '--explosions INTEGER', Numeric , 'the maximum amount of die explosions that can occur') do |o|
        explosions = o
    end
end.parse!

puts get_dice_probabilities(ARGV, explosions)
