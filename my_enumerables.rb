module Enumerable
  # Your code goes here
  def my_each_with_index

    return to_enum(:my_each_with_index) unless block_given?

    i = 0
    while i < self.length
      yield self[i] , i
      i = i + 1
    end
    self     
  end

  def my_select

    i = 0
    output_array = []
    output_hash = {}
    while i < self.length
      if Array === self
        yield self[i]
        if yield self[i]
          output_array.push(self[i])
        end

      elsif Hash === self
        yield self.values[i]
        if yield self.values[i]
          output_hash[self.keys[i]]=self.values[i]
        end
      end
      i = i + 1 
    end
    if Array === self
      return output_array
    elsif Hash === self
      return output_hash
    # else
    #   return array[]
    end

  end

  #my_all?
  # When all elements match the condition
  #returns true 
  # When any element does not match the condition
  # returns false
  def my_all?

    i = 0
    true_elements = 0

    while i < self.length
      yield self[i]
      if yield self[i]
        true_elements = true_elements + 1
      end      
      i = i + 1
    end
    
    if true_elements == self.length
      return true
    else
      false
    end
  end

  def my_any?
    
    i = 0
    false_element = 0
    true_element = 0

    while i < self.length
      yield self[i]
      if yield self[i]
        true_element = true_element + 1
        return true
      else
        false_element = false_element + 1
      end
      i = i + 1
    end

    if false_element == self.length
      return false
    end
       
  end

  #when no elements match the condition returns true

  #when any element matches the condition returns false

  def my_none?

    i = 0
    false_element = 0
    true_element = 0

    while i < self.length
      yield self[i]
      if yield self[i]
        true_element = true_element + 1
      else
        false_element = false_element + 1
      end
      i = i + 1
    end
    if true_element == 0
      true
    elsif true_element > 1
      false
    end
  end

  def my_count

    return self.size unless block_given?
    i = 0
    true_elements = 0

    while i < self.length
      yield self[i]
      if yield self[i]
        true_elements = true_elements + 1
      end
      i = i + 1
    end

    true_elements
  end

  def my_map(&symbol)
    i = 0
    array = []
    
    while i < self.length
      
      array[i] = yield self[i]
      i = i + 1
    end
    array
  end

  def my_inject initial_value=nil
    accum = initial_value ? initial_value : self.first
    if initial_value
      my_each { |elem| accum = yield(accum, elem) }
    else
      shifted = is_a?(Hash) ? slice(keys[1], keys[-1]) : self[1..-1]
      shifted.my_each { |elem| accum = yield(accum, elem) }
    end
    accum
  end
    
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
# Define my_each here
  include Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?
    for element in self do
      yield element
    end
    self
  end  
end

