require "spec_helper"

describe Header do

  before(:all) do
    test_db_path = File.dirname(__FILE__) + "/resources/test.db"
    stream = File.open(test_db_path)
    @header = Header.new(stream)
    stream.close
  end

  it "should read the magic string" do
    @header.well_known_string.should == "SQLite format 3"
  end

  it "should read the page size" do
    @header.page_size.should == 2048
  end

  it "should read write version" do
    @header.write_version.should == 1
  end

  it "should read the read version" do
    @header.read_version.should == 1
  end

end