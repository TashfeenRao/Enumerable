# frozen_string_literal: true

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

array = %w[hello hi heee]
my_all(array) { |i| i[0] == 'h' }
