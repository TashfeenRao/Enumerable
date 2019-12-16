# frozen_string_literal: true

# rubocop:disable Metrics/ModuleLength

module Enumerable
  def my_each
    return to_enum unless block_given?

    i = 0
    while i < size
      yield self[i]
      i += 1
    end
    self
  end

  def my_each_with_index
    return to_enum unless block_given?

    i = 0
    while i < size
      yield(self[i], i)
      i += 1
    end
    self
  end

  def my_select
    return to_enum unless block_given?

    is_a?(Array) ? self : to_a
    temp = []
    my_each do |j|
      yield(j) ? temp.push(j) : next
    end
    temp
  end

  def my_all?(pattern = nil) # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    result = true
    current = self
    if !block_given? && pattern.nil?
      current.my_each do |item|
        result = false unless item
      end
    elsif pattern.is_a? Regexp
      current.my_each do |item|
        result = true unless pattern == item
      end
    elsif pattern.is_a? Class
      current.my_each do |item|
        result = false unless item.is_a? pattern
      end
    elsif pattern
      current.my_each do |item|
        result = false unless item == pattern
      end
    elsif is_a? Array
      current.my_each do |item|
        result = false unless yield(item)
      end
    elsif is_a? Hash
      current.my_each do |k, v|
        result = false unless yield(k, v)
      end
    end
    result
  end

  def my_any?(pattern = nil) # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    current = self
    result = false
    if !block_given? && pattern.nil?
      current.my_each do |item|
        result = true if item
      end
    elsif pattern.is_a? Regexp
      current.my_each do |item|
        result = true if item =~ pattern
      end
    elsif pattern.is_a? Class
      current.my_each do |item|
        result = true if item.is_a? pattern
      end
    elsif pattern
      current.my_each do |item|
        result = true if item == pattern
      end
    elsif is_a? Array
      current.my_each do |item|
        result = true if yield(item)
      end
    elsif is_a? Hash
      current.my_each do |k, v|
        result = true if yield(k, v)
      end
    end
    result
  end

  def my_none?(pattern = nil) # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    result = false
    current = self
    if !block_given? && pattern.nil?
      current.my_each do |item|
        result = true if item
      end
    elsif pattern.is_a? Class
      current.my_each do |item|
        result = true if item.is_a? pattern
      end
    elsif pattern.is_a? Regexp
      current.my_each do |item|
        result = true if item =~ pattern
      end
    elsif pattern.is_a? Array
      current.my_each do |item|
        result = true if yield(item)
      end
    elsif pattern
      current.my_each do |item|
        result = true if item == pattern
      end
    end
    result
  end

  def my_count(parameter = nil)
    count = 0
    if block_given?
      my_each { |i| count += 1 if yield(i) }
    elsif !parameter.nil?
      my_each { |i| count += 1 if i == parameter }
    else
      count = length
    end
    count
  end

  def my_map
    return to_enum unless block_given?

    i = 0
    new_map = []
    while i < size
      new_map << yield(self[i])
      i += 1
    end
    new_map
  end

  def my_inject(initial_value = nil, symbol = nil) # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    if !initial_value.nil? && !symbol.nil?
      my_each { |num| initial_value = initial_value.method(symbol).call(num) }
      initial_value
    elsif !initial_value.nil? && initial_value.is_a?(Symbol) && symbol.nil?
      memo, *remaining_elements = self
      remaining_elements.my_each { |num| memo = memo.method(initial_value).call(num) }
      memo
    elsif !initial_value.nil? && initial_value.is_a?(Integer) && symbol.nil?
      my_each { |num| initial_value = yield(initial_value, num) }
      initial_value
    elsif initial_value.nil? && symbol.nil?
      initial_value, *remaining_elements = self
      remaining_elements.my_each { |num| initial_value = yield(initial_value, num) }
      initial_value
    end
  end

  def my_map_modify_1(&proc)
    i = 0
    new_map = []
    while i < self[i]
      new_map << proc.call(self[i])
      i += 1
    end
    new_map
  end

  def my_map_modify_2(para = nil)
    i = 0
    new_map = []
    while i < self[i]
      if para.nil? && block_given?
        new_map << yield(self[i])
      elsif !para.nil? && block_given?
        new_map << proc.call(self[i])
      end
      i += 1
    end
    new_map
  end
end
def multiply_els(arr)
  arr.my_inject { |memo, val| memo * val }
end
# rubocop:enable Metrics/ModuleLength
