require 'minitest/autorun'
require_relative '../dice_exploder.rb'

describe ExplodingRoll do
    describe "Exploding calculates odds correctly" do
        before do
            @die = Die.new(6)
            @die2 = Die.new(4)
        end

        it 'gets the roll distribution' do
            roll = ExplodingRoll.new(dice: [@die, @die2])
            dist = roll.get_distribution()
            assert_equal dist.length, 24
            assert_equal dist[0].value, 2
            assert_equal dist[23].value, 10
            assert_equal dist[23].odds, Rational(1, 24)
            assert_equal dist[5].odds, Rational(1, 24)
        end

        it 'roll distribution odds add to 1' do
            roll = ExplodingRoll.new(dice: [@die, @die2])
            dist = roll.get_distribution()
            ods = dist.reduce(0) do |acc, res|
                acc + res.odds
            end
            assert_equal 1, ods
        end

        it 'roll explosion distribution odds add to 1' do
            roll = ExplodingRoll.new(dice: [@die], explosions: 3)
            dist = roll.get_distribution()
            ods = dist.reduce(0) do |acc, res|
                acc + res.odds
            end
            assert_equal 1, ods
        end

        it 'roll explosion correctly does not have highest value of side' do
            roll = ExplodingRoll.new(dice: [@die], explosions: 1)
            dist = roll.get_distribution()
            assert_equal dist[5].value, 7
        end

        it 'roll explosion correctly decreases odds on explosion number' do
            roll = ExplodingRoll.new(dice: [@die], explosions: 1)
            dist = roll.get_distribution()
            assert_equal dist[7].odds, Rational(1,36)
        end
    end
end