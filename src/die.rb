class Die
    attr_reader :probability, :sides
    def initialize(sides)
        @sides = sides.to_i
        if(@sides <= 0) then
            throw "Error, die must have more than 0 sides"
        end
        @probability = Rational(1, @sides)
    end

    def values
        @values ||= (1..@sides)
    end

    def get_result(value)
        probability = self.values.include?(value) ? @probability : Rational(0)
        Result.new(value: value, odds: probability)
    end

    def get_all_results()
        self.values.map {|val| self.get_result(val)}
    end
end