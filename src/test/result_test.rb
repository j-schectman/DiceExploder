
require 'minitest/autorun'
require_relative '../results_list.rb'
require_relative '../result.rb'
require_relative '../die.rb'

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
end

describe ResultOld do
    describe "Results correctly sets probability and value" do
        before do
        end

        it 'Sets value to 1 when no value given' do
            result = ResultOld.new(6, Rational(1/6), 0)
            assert_equal 1, result.value
        end

        it 'Correctly increments to next die' do
            result = ResultOld.new(6, Rational(1/6), 0)
            nextRes = result.next
            assert_equal 2, nextRes.value
        end

        it 'Correctly returns null when no more result' do
            result = ResultOld.new(6, Rational(1,6), 0, 6)
            nextRes = result.next
            assert_equal nil, nextRes
        end

        it 'Correctly determines if its an explosion value' do
            exp_result = ResultOld.new(6, Rational(1,6), 1, 6)
            big_exp_result = ResultOld.new(6, Rational(1,6), 2, 12)
            result = ResultOld.new(6, Rational(1,6), 0, 3)
            assert_equal true, exp_result.explosion_die
            assert_equal true, big_exp_result.explosion_die
            assert_equal false, result.explosion_die
        end

        it 'Correctly returns more die if explosions >0' do
            exp_result = ResultOld.new(6, Rational(1,6), 1, 6)
            assert_equal true, !!exp_result.next
        end

        it 'correctly determines the probability of a explosions' do
            result = ResultOld.new(6, Rational(1,6), 2, 6)
            b_result = result.next
            assert_equal Rational(1, 36), b_result.probability
        end

    end
end