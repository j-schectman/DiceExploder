class Result
    attr_reader :odds
    attr_reader :value
    def initialize (value:, odds:)
        @odds = odds
        @value = value
    end

    def self.combine(result, other_result = Result.new(value: 0, odds: Rational(0)))
        newValue = result.value + other_result.value
        newOdds = result.odds * other_result.odds
        Result.new(value: newValue, odds: newOdds)
    end

    def | (other)
        Result.combine(self, other)
    end
end
