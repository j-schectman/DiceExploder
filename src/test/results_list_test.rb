
require 'minitest/autorun'
require_relative '../results_list.rb'
require_relative '../die.rb'

describe ResultsList do
    describe "ResultsList correctly creates a linked list" do
        before do
            @die = Die.new(2)
            @results = ResultsList.new(@die)
        end

        it 'Generates an array with correct length' do
            length = @results.length
            assert_equal 2, @results.length
        end

        it 'Generates an Enumerator with correct size' do
            assert_equal 2, @results.each().size
        end

        it 'Take 1 correctly returns first item from each' do
            assert_equal true, !!@results.each.take(1)[0]
        end

        it 'Returns a list equal to the length' do
            bDie = Die.new(6)
            @results = ResultsList.new(bDie)
            assert_equal 6, @results.each.take(6).length
        end

        it 'Returns a ResultOld with a correct value' do
            bDie = Die.new(6)
            results = ResultsList.new(bDie)
            result = results.each.take(3)[2]
            assert_equal 3, result.value
            assert_equal Rational(1,6), result.probability
        end

        it 'Correctly skips an explosion die' do
            bDie = Die.new(6)
            results = ResultsList.new(bDie, 1)
            result = results.each.take(7)[6]
            assert_equal 8, result.value
        end
    end
end