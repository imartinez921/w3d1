require "byebug"

class Array

    def my_each(&prc) #blocks don't have .call but procs do
        i = 0   
        while i < self.length
            prc.call(self[i]) #calling prc on each index of self
            i += 1
        end
        self
    end

    def my_select(&prc)
        collection = []
        self.my_each do |ele|
            collection << ele if prc.call(ele)
        end
        return collection
    end

    def my_reject(&prc)
        collection = []
        self.my_each do |ele|
            collection << ele if !prc.call(ele)
        end
        return collection
    end

    def my_any?(&prc)
        self.my_each { |ele| return true if prc.call(ele)}
        return false
    end

    def my_all?(&prc)
        self.my_each { |ele| return false if !prc.call(ele)}
        return true
    end

    def my_flatten
        resultArr = []
        
        self.my_each do |ele|
            if ele.is_a?(Array)
                resultArr += ele.my_flatten
            else resultArr << ele
            end
        end

        return resultArr
        # i = 0
        # while i < self.length
        #     if self[i].is_a?(Array)
        #         resultArr << my_flatten(self[i])
        #     else
        #         resultArr << self[i]
        #     end
        # end #this brings an infinite loop
    end


    def my_zip(*args) #
        resultArr = []
        i = 0
        collection = []
        while i < self.length
            collection = []
            collection << self[i]
            args.each do |array|
                collection << array[i]
            end
            resultArr << collection
            i += 1
        end
        return resultArr
    end


    def my_rotate(num=1)
        resultArr = self.map {|ele| ele}

        i = 0
        until i == num # increment or decrement num depending on whether num is + or -
            if num.positive?
                front = resultArr.shift
                resultArr << front
                i += 1
            elsif num.negative?
                back = resultArr.pop
                resultArr.unshift(back)
                i -= 1
            end
        end
        return resultArr
    end

    def my_join(*separator)
        ansStr = ""

        i = 0
        until i == self.length - 1 #go up to before last character
            ansStr << self[i]
            ansStr << separator[0] if !separator.empty?
            i += 1
        end
        ansStr << self[-1] #adds last ele without separator
        return ansStr
    end

    
    def my_reverse
        ansArr = []
        i = self.length - 1    
        while i >= 0
            ansArr << self[i]
            i -= 1
        end
        return ansArr
    end



end

p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
p [ 1 ].my_reverse  