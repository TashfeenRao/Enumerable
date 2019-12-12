# frozen_string_literal: true

module Enumerable
  def my_each(array)
    i = 0
    while i < array.size
      yield array[i]
      i += 1
    end
    array
  end

  def my_each_with_index(array)
    i = 0
    while i < array.size
      yield(array[i], i)
      i += 1
    end
    array
  end

  def my_select(array)
    i = 0
    select_array = []
    while i < array.size
      select_array << yield(array[i])
      i += 1
    end
    select_array
  end

  def my_all(array)
    i = 0
    result = nil
    while i < array.size
      result = if yield(array[i])
                 true
               else
                 false
               end
      i += 1
    end

    puts result
  end

  def my_any(array)
    i = 0
    result = nil
    while i < array.size
      result = if yield(array[i])
                 true
               else
                 false
               end
      i += 1
    end

    puts result
  end

  def my_none(array)
    i = 0
    result = nil
    while i < array.size
      result = if yield(array[i])
                 false
               else
                 true
               end
      i += 1
    end

    puts result
  end

  def my_count(array)
    i = 0
    count = 0
    while i < array.size
      result = (count += 1 if yield(array[i]))
      i += 1
    end

    puts count
  end

  def my_map(array)
    i = 0
    new_map = []
    while i < array.size
      new_map << yield(array[i])
      i += 1
    end
    new_map
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

  array = [2, 4, 5]
end
