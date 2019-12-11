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


array = %w[hello hi heee]
my_select(array) do |k| puts "my select #{k}" end
my_each_with_index(array) do |v, i|
  puts "#{v}#{i}"
end
my_each(array) do |v|
  puts v.to_s
end
