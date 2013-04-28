
require_relative 'test_helper'

class PeaksTest < MiniTest::Unit::TestCase
  def test_empty_array
    assert_nil Peaks.find_peaks([], 1)
  end

  def test_highest_in_middle
    assert_equal 3, Peaks.find_peaks([1,3,2], 1)
  end

  def test_highest_on_end
    assert_nil Peaks.find_peaks([1,2,3], 1), "last item can't be peak"
    assert_nil Peaks.find_peaks([3,2,1], 1), "first item can't be peak"
  end

  def test_peak_higher_than_n
    sample = [1,2,3,2,1]
    highest = 3
    assert_equal highest, Peaks.find_peaks(sample, 1), "1"
    assert_equal highest, Peaks.find_peaks(sample, 2), "2"
    assert_nil Peaks.find_peaks(sample, 3), "not higher than enough others"
  end

  def test_duplicate_peaks
    sample = [1,3,3,3,1]
    highest = 3
    assert_equal highest, Peaks.find_peaks(sample, 1), "1"
    assert_equal highest, Peaks.find_peaks(sample, 2), "2, only works because one of the dups is in a good spot"
  end

  def test_with_block
    tv = Struct.new(:val)
    sample = [tv.new(1), tv.new(2), tv.new(1)]
    highest = sample[1]

    assert_equal highest, Peaks.find_peaks(sample, 1) { |v| v.val }, "didn't find peak with block given"
    assert_raises(NoMethodError) { Peaks.find_peaks(sample, 1) }
  end
end
