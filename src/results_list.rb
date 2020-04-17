
class ResultOld
    attr_reader :probability
    attr_reader :value

    def initialize(sides, probability, explosions, value = nil)
        @sides = sides
        @probability = probability
        @explosions = explosions
        @value = value == nil ? 1 : value
    end

    def explosion_die()
        @value % @sides == 0
    end

    def next()
        if(@value < @sides * (@explosions + 1))
            probability = (self.explosion_die && @explosions > 0) ? Rational(1, @sides) * @probability : @probability
            ResultOld.new(@sides, probability, @explosions, @value + 1)
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

    def each
        Enumerator.new(self.length) do |y|
            result = ResultOld.new(@die.sides, @die.probability, @explosions)
            until result == nil do
                if(result.explosion_die)
                    result = result.next
                end
                y << result
                result = result.next
            end
        end
    end
end