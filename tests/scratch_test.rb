require_relative '../lib/scratch'
require 'minitest/autorun'
require 'minitest/pride'

class PeopleDatabaseTest < Minitest::Test
  def test_more_than_11_digits_fails
    refute clean_phone("123472365783")
    refute clean_phone("4039828d4500")
    refute clean_phone("000398284523")
  end

  def test_less_than_10_digits_fails
    refute clean_phone("890234857")
    refute clean_phone("234678300")
    refute clean_phone("001238473")
  end

  def test_11_digits_without_leading_1_fails
    refute clean_phone("48403982845")
    refute clean_phone("00403982845")
    refute clean_phone("40398284500")
  end

  def test_10_digits_passes
    assert_equal "8403982845", clean_phone("8403982845")
    assert_equal "0001928345", clean_phone("0001928345")
    assert_equal "1234780000", clean_phone("1234780000")
  end

  def test_11_digits_with_leading_1_passes
    assert_equal "8403982845", clean_phone("18403982845")
    assert_equal "0012312434", clean_phone("10012312434")
    assert_equal "9341893400", clean_phone("19341893400")
  end
end
