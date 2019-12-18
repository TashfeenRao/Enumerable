# rubocop:disable all

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

  def my_all?(*arg)

    return grep(arg.first).length == size unless arg.empty?

    my_each { |el| return false unless yield(el) } if block_given?
    my_each { |el| return false unless el } unless block_given?
    true
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

  def my_none?(*arg)
    return grep(arg.first).empty? unless arg.empty?

    my_each { |el| return false if yield(el) } if block_given?
    my_each { |el| return false if el } unless block_given?
    true
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

  def my_inject(pattern = nil, str = nil)
    tmp = is_a?(Range) ? to_a : self
    memo = pattern.nil? || pattern.is_a?(Symbol) ? tmp[0] : pattern
    if block_given?
      start = pattern ? 0 : 1
      tmp[start..-1].my_each { |e| memo = yield(memo, e) }
    end
    tmp[1..-1].my_each { |e| memo = memo.send(pattern, e) } if pattern.is_a?(Symbol)
    tmp[0..-1].my_each { |e| memo = memo.send(str, e) } if str
    memo
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
range = [5,6,7,8,9,10]
p expected = range.my_inject(4) { |prod, n| prod * n }
def multiply_els(arr)
  arr.my_inject { |memo, val| memo * val }
end



# rubocop:enable all
