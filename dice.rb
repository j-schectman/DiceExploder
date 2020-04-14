class Die
    def initialize(sides)
        @sides = sides.to_i
        if(@sides <= 0) then
            throw "Error, die must have more than 0 sides"
        end
        @probability = Rational(1, @sides)
    end

    def get_probability()
        return @probability
    end

    def get_probability_range(explosion_n)

        # If there are no explosions listed, then just give the probability of the die being rolled.
        if( explosion_n == nil) then
            return ( 1..(@sides) ).map { |val|
                [val, @probability]
        }

        if(explosion_n < 0) then
            throw "Error, explosion rate must be greater than or equal to 0"
        end
        elsif(explosion_n == 0) then
            return ( 1..(@sides - 1) ).map { |val|
                [val, @probability]
            }
        elsif(explosion_n > 0) then
            return self.get_probability_range(explosion_n-1).to_a | self.get_explosion_range(explosion_n).to_a
        end
    end

    def get_explosion_range(explosions_n)
        explosion_prob = @probability ** (explosions_n + 1) 
        return ( 1 + (@sides * explosions_n)..(@sides * (explosions_n + 1)) ).map {
            |val|
            [val, explosion_prob]
        }
    end 
end

def get_dice_probabilities(list_sides, explosion_limit = nil)
    die = list_sides.map { |x| Die.new(x) }
    prob_list = die.map {|die| die.get_probability_range(explosion_limit)}

    # Handle the case when only 1 die is provided.
    if(prob_list.length == 1) then
        return Hash[prob_list[0].map {|key, value| [key, value]}]
    end
    hash = {}

    # Iterate through the list of probabilities and create a hash by
    # Adding the value of each die side and mulitplying the probability.

    ( 0...prob_list.length ).each { |i|
        list1 = prob_list[i]
        ((i + 1)...prob_list.length ).each { |j|
            list2 = prob_list[j]
            list1.each {
                |val1|
                list2.each {|val2|
                    value = val1[0] + val2[0]
                    current_prob = hash.has_key?(value) ? hash[value] : 0
                    hash[value] = current_prob + (val1[1] * val2[1])
                }
            }
        }
    }
    hash
end
