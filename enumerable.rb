# frozen_string_literal: true

# rubocop:disable Metrics/ModuleLength
module Enumerable
  def my_each
    i = 0
    while i < size
      yield self[i]
      i += 1
    end
    array
  end

  def my_each_with_index
    i = 0
    while i < size
      yield(self[i], i)
      i += 1
    end
    array
  end

  def my_select
    i = 0
    select_array = []
    while i < size
      select_array << yield(self[i])
      i += 1
    end
    select_array
  end

  def my_all?
    i = 0
    result = nil
    while i < size
      result = if yield(self[i])
                 true
               else
                 false
               end
      i += 1
    end

    result
  end

  def my_any?
    i = 0
    result = nil
    while i < size
      result = if yield(self[i])
                 true
               else
                 false
               end
      i += 1
    end

    result
  end

  def my_none?
    i = 0
    result = nil
    while i < size
      result = if yield(self[i])
                 false
               else
                 true
               end
      i += 1
    end

    result
  end

  def my_count
    i = 0
    count = 0
    while i < size
      count += 1 if yield(self[i])
      i += 1
    end

    count
  end

  def my_map
    if block_given?
      i = 0
      new_map = []
      while i < size
        new_map << yield(self[i])
        i += 1
      end
      new_map
    else
      puts 'block is not given'
    end
  end

  def my_inject(memo = nil)
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

# rubocop:enable Metrics/ModuleLength
