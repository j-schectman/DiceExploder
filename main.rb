#!/usr/bin/env ruby
require File.expand_path(File.join(File.dirname(__FILE__), 'dice_exploder'))
require 'optparse'

explosions = nil
OptionParser.new do |opt|
    opt.on('-e', '--explosions INTEGER', Numeric , 'the maximum amount of die explosions that can occur') do |o|
        explosions = o
    end
end.parse!

die = ARGV.map { |x| Die.new(x.to_i) }

exploder = ExplodingRoll.new(dice: die, explosions: explosions)

puts exploder.get_distribution.reduce({}){|acc, current|
    acc[current.value] = current + acc[current.value]
    acc
}.to_a