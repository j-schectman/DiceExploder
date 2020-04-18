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

    # Just doing this because, probably not right
    def self.sum(result, other_result = Result.new(value: result.value, odds: Rational(0)))
        other_result = other_result || Result.new(value: result.value, odds: Rational(0))
        if(result.value != other_result.value) 
            throw 'Two results with different values cannot be added'
        end
        newOdds = result.odds + other_result.odds
        Result.new(value: result.value, odds: newOdds)
    end

    def +(other)
        Result.sum(self, other)
    end

    def | (other)
        Result.combine(self, other)
    end

    def to_s 
        "#{@value} #{@odds}"
    end
end
