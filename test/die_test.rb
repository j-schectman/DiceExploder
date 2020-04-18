require 'minitest/autorun'
require_relative '../dice_exploder.rb'

describe Die do
    describe "Die sets correct probability" do
        before do
            @die = Die.new(6)
        end
        it 'Has a probability of rolling a side of 1/6' do
            assert_equal @die.probability(), Rational(1, 6)
        end
        it 'Returns the list of possible values' do
            assert_equal @die.values.include?(6), true
            assert_equal @die.values.include?(3), true
        end
        it 'Returns a result if it is a possibility' do
            assert_equal !!@die.get_result(4), true
        end
        it 'Returns a result with correct odds' do
            assert_equal @die.get_result(4).odds, Rational(1,6)
        end
        it 'Returns an impossible result with correct odds' do
            assert_equal !!@die.get_result(8), true
            assert_equal @die.get_result(8).odds, Rational(0,6)
        end
    end
end