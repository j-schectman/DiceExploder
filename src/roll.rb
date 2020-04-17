class Roll 
    attr_reader :dice
    def initialize(dice:)
        @dice = dice
    end

    def get_distribution
        @distribution ||= self.get_rolls.reduce {
            |acc, die|
            ret = []
            acc.each {
                |res|
                die.each {
                    |res2|
                    ret.push(res | res2)
                }
            }
            ret
    }
    end

    def get_rolls
        @rolls ||= @dice.map(&:get_all_results)
    end
    
    def get_all_results()
        self.values.map {|val| self.get_result(val)}
    end
end

class ExplodingRoll < Roll
    def initialize(dice:, explosions: 0)
        super(dice: dice)
        @explosions = explosions
    end

    def get_rolls
        @rolls ||= @dice.map do |die|
            res = die.get_all_results
            @explosions.times do ||
                exp = res.pop()
                res = res | die.get_all_results.map do |c|
                    c | exp
                end
            end
            res
        end
    end
end