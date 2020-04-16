require 'minitest/autorun'
require_relative '../die_probabilities.rb'
require_relative '../die.rb'

describe DieProbabilities do
    describe "Die" do
        before do
            @die = Die.new(2)
            @results = DieProbabilities.new(@die).get_probabilities()
        end
        it 'Generates an array with correct number of results' do
            # assert_equal @results.length, 2
        end
    end
end