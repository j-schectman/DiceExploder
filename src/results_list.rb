
class Result
    def initialize(sides, probability, explosions, value = nil)
        @sides = sides
        @probability = probability
        @explosions = explosions
        @value = value == nil ? 1 : value
    end

    def probability()
        @probability 
    end

    def explosion_die()
        @value % @sides == 0
    end

    def value()
        @value
    end

    def next()
        if(@value < @sides * (@explosions + 1))
            probability = (self.explosion_die && @explosions > 0) ? Rational(1, @sides) * @probability : @probability
            Result.new(@sides, probability, @explosions, @value + 1)
        end
    end
end

class ResultsList
    def initialize(die, explosions = 0)
        @explosions = explosions
        @die = die
    end

    def length
        (@die.sides * (@explosions + 1)) - @explosions
    end

    def each(&block)
        enum = Enumerator.new(self.length) do |y|
            result = Result.new(@die.sides, @die.probability, @explosions)
            until result == nil do
                if(result.explosion_die)
                    result = result.next
                end
                y << result
                result = result.next
            end
        end

        if(block == nil) 
            return enum
        else
            return enum.each { |val| }
        end 
    end
end