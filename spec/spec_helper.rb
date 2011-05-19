require 'bundler/setup'
require 'rspec'
require 'pure-sqlite'

RSpec.configure do |c|
  include PureSQLite
end

module PureSQLite

  def open_test_db
    test_db_path = File.dirname(__FILE__) + "/resources/test.db"
    stream = File.open(test_db_path)
    yield stream
    stream.close
  end

end
