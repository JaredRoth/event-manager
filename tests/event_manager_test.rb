require_relative '../lib/event_manager'
require 'minitest/autorun'
require 'minitest/pride'

class EventManagerTest < Minitest::Test
  def test_more_than_11_digits_fails
    assert_equal "Bad Number", validate_phone("123472365783")
    assert_equal "Bad Number", validate_phone("4039828d4500")
    assert_equal "Bad Number", validate_phone("000398284523")
  end

  def test_less_than_10_digits_fails
    assert_equal "Bad Number", validate_phone("890234857")
    assert_equal "Bad Number", validate_phone("234678300")
    assert_equal "Bad Number", validate_phone("001238473")
  end

  def test_11_digits_without_leading_1_fails
    assert_equal "Bad Number", validate_phone("48403982845")
    assert_equal "Bad Number", validate_phone("00403982845")
    assert_equal "Bad Number", validate_phone("40398284500")
  end

  def test_10_digits_passes
    assert_equal "8403982845", validate_phone("8403982845")
    assert_equal "0001928345", validate_phone("0001928345")
    assert_equal "1234780000", validate_phone("1234780000")
  end

  def test_11_digits_with_leading_1_passes
    assert_equal "8403982845", validate_phone("18403982845")
    assert_equal "0012312434", validate_phone("10012312434")
    assert_equal "9341893400", validate_phone("19341893400")
  end
end
