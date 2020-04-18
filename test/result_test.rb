
require 'minitest/autorun'
require_relative '../dice_exploder.rb'
describe Result do
        it 'correctly combines results' do
            result = Result.new(value: 6, odds: Rational(1, 6))
            result2 = Result.new(value: 3, odds: Rational(1, 3))
            combResult = Result.combine(result, result2)
            assert_equal combResult.odds, Rational(1, 18)
            assert_equal combResult.value, 9
        end
        it 'can merge two results' do
            result = Result.new(value: 6, odds: Rational(1, 6))
            result2 = Result.new(value: 3, odds: Rational(1, 3))
            combResult = result | result2
            assert_equal combResult.odds, Rational(1, 18)
            assert_equal combResult.value, 9
        end
        it 'can sum two results' do
            result = Result.new(value: 6, odds: Rational(1, 6))
            result2 = Result.new(value: 6, odds: Rational(1, 3))
            combResult = result + result2
            assert_equal combResult.odds, Rational(1, 2) 
            assert_equal combResult.value, 6
        end
end