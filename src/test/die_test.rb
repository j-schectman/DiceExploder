require 'minitest/autorun'
require_relative '../die.rb'

describe Die do
    describe "Die sets correct probability" do
        before do
            @die = Die.new(6)
        end
        it 'Has a probability of rolling a side of 1/6' do
            assert_equal @die.probability(), Rational(1, 6)
        end
    end
end