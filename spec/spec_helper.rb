require 'bundler/setup'
require 'rspec'
require 'pure-sqlite'

RSpec.configure do |c|
  include PureSQLite
end

module PureSQLite

  def test_db_filename
    File.dirname(__FILE__) + "/resources/test.db"
  end

  def open_test_db
    stream = File.open(test_db_filename)
    yield stream
    stream.close
  end

end
