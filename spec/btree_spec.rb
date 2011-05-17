require "spec_helper"

describe Header do

  before(:all) do
    test_db_path = File.dirname(__FILE__) + "/resources/test.db"
    stream = File.open(test_db_path)
    @header = Header.new(stream)
    stream.close
  end
end