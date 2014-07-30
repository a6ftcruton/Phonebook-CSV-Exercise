
require_relative 'entry'
require 'csv'

class EntryRepository

  attr_reader :entries

  def self.load_entries(directory)
    file = File.join(directory, 'people.csv')
    data = CSV.open(file, headers: true, header_converters: :symbol)
    rows = data.map do |row|
      Entry.new(row)
    end
    new(rows)
  end

  def initialize(entries)
    @entries = entries
  end

  def find_by_last_name(name)
    entries.select { |entry| entry.last_name == name}
  end

  def find_by_first_and_last_name(first_name, last_name)
    entries.select { |entry| entry.last_name == last_name && entry.first_name == first_name}
  end

  def find_by_phone(phone)
    entries.select {|entry| entry.phone_number.gsub(/[^\d]/, '') == phone.gsub(/[^\d]/, '') }
  end
end
