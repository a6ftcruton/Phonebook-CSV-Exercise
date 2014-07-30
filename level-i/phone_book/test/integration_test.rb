gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/phone_book'
require_relative '../lib/entry_repository'

class IntegrationTest < Minitest::Test

  def test_lookup_by_last_name
    phone_book = PhoneBook.new
    entries = phone_book.lookup('Parker').sort_by {|e| e.first_name}
    assert_equal 3, entries.length
    e1, e2, e3 = entries

    assert_equal "Agnes Parker", e1.name
    assert_equal "758.942.6890", e1.phone_number

    assert_equal "Craig Parker", e2.name
    assert_equal "716-133-3210", e2.phone_number

    assert_equal "Mohamed Parker", e3.name
    assert_equal "701-655-6889", e3.phone_number
  end

  def test_lookup_by_last_and_first_name
    phone_book = PhoneBook.new
    entries = phone_book.lookup('Parker, Craig').sort_by {|e| e.first_name}
    assert_equal 1, entries.length
    entry = entries.first
    assert_equal "Craig Parker", entry.name
    assert_equal "716-133-3210", entry.phone_number
  end

  def test_reverse_lookup
    phone_book = PhoneBook.new
    entries = phone_book.reverse_lookup("71.6-133-3*21.0")

    assert_equal 1, entries.length
    entry = entries.first
    assert_equal "Craig Parker", entry.name
    assert_equal "716-133-3210", entry.phone_number
  end


end
