# frozen_string_literal: true

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

    i = 0
    select_array = []
    while i < size
      select_array << yield(self[i])
      i += 1
    end
    select_array
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
        result = item =~ pattern
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
    puts result
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
    puts result
  end

  def my_none?(pattern = nil) # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    result = true
    current = self
    if !block_given? && pattern.nil?
      current.my_each do |item|
        result = false if item
      end
    elsif pattern.is_a? Class
      current.my_each do |item|
        result = false if item.is_a? pattern
      end
    elsif pattern.is_a? Regexp
      current.my_each do |item|
        result = false if item =~ pattern
      end
    elsif pattern.is_a? Array
      current.my_each do |item|
        result = false if yield(item)
      end
    elsif pattern
      current.my_each do |item|
        result = false if item == pattern
      end
    end
    puts result
  end

  def my_count
    return to_enum unless block_given?

    i = 0
    count = 0
    while i < size
      count += 1 if yield(self[i])
      i += 1
    end

   puts count
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

  def my_inject(memo = nil)
    return to_enum unless block_given?

    i = 0
    memo ||= self[0]
    while i < size
      memo = yield(memo, self[i])
      i += 1
    end
    memo
  end

  def multiply_els(arr)
    arr.my_inject { |memo, val| memo * val }
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
[1,2,3,4,5].my_count
