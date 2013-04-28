require_relative 'test_helper'

class ArrayTest < MiniTest::Unit::TestCase
  def test_empty_array
    assert_empty [].peaks(2)
  end

  def test_short_array_of_ints
    sample = [1,2,3,2,1]
    assert_equal [3], sample.peaks(2)
  end

  def test_long_array_with_2_peaks
    sample = [1,2,3,2,1,4,1,1]
    assert_equal [3,4], sample.peaks(2)
  end

  def test_long_array_with_multiple_different_objects
    tc = Struct.new(:id, :val)
    sample_vals = [1,2,3,3,1,4,1,1]
    sample = []
    sample_vals.each_with_index { |v, i|
      sample << tc.new(i, v)
    }

    correct = [sample[2], sample[5]]
    
    assert_equal correct, sample.peaks(2) { |v| v.val }
  end


end
