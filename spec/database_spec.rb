require "spec_helper"

describe Database do

  before(:all) do
    Database.open(test_db_filename) do |db|
      @tables = db.tables
    end
  end

  it "should contain table_one" do
    @tables[0].should == "table_one"
  end

  it "should contain table_two" do
    @tables[1].should == "table_two"
  end

end