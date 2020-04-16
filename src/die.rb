class Die
    def initialize(sides)
        @sides = sides.to_i
        if(@sides <= 0) then
            throw "Error, die must have more than 0 sides"
        end
        @probability = Rational(1, @sides)
    end

    def probability()
        return @probability
    end

    def sides()
        return @sides
    end
end