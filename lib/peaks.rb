require "peaks/version"

module Peaks
  def self.find_peaks(arr, n, &block)
    return nil if (!arr.respond_to?(:each_with_index) || arr.empty?)

    block = ->(v){ v }  unless block_given?

    max = block.call(arr[0])
    max_index = 0

    arr.each_with_index do |v, i|
      next if i == 0
      candidate = block.call(v)
      if candidate > max
        max = candidate
        max_index = i
      end
    end

    if arr.select { |v| v == max }.length > 1
      return find_acceptable_max(max, arr, n, block)
    else
      return nil unless acceptable_index?(arr.length, max_index, n)
      return arr[max_index]
    end
  end


  def self.find_acceptable_max(max, arr, n, block)
    length = arr.length
    arr.each_with_index do |v, i| 
      if block.call(v) == max
        return v if acceptable_index?(length, i, n)
      end
    end

    nil
  end


  def self.acceptable_index?(length, index, n)
    return false if index < n
    return false if (length - 1 - n) < index

    true
  end

end


module Enumerable
  def peaks(n, &block)
    peak_list = []
    self.each_cons(n * 2 + 1) do |arr|
      peak_list << Peaks.find_peaks(arr, n, &block)
    end

    peak_list.compact.uniq
  end
end
