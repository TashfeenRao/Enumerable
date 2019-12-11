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


array = %w[hello hi heee]
my_each_with_index(array) do |v, i|
  puts "#{v}#{i}"
end
my_each(array) do |v|
  puts v.to_s
end
