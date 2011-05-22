require "spec_helper"

describe DatabaseRecord do

  context "when reading the first page" do

    before(:each) do
      open_test_db_stream do |io|
        header  = Header.new(io)
        page    = Page.new(header, 1, io)
        cell    = page.cells.first
        @database_record = cell.database_record
      end
    end

    it "should have a header of 6 bytes" do
      @database_record.total_header_bytes.should == 6
    end

    it "should have a 5 data elements" do
      @database_record.entries.length.should == 5
    end

    it "should read the first entry" do
      get_data(0).type.should == :text
      get_data(0).length.should == 5
      get_data(0).value.should == 'table'
    end

    it "should read the second entry" do
      get_data(1).type.should == :text
      get_data(1).length.should == 9
      get_data(1).value.should == 'table_one'
    end

    it "should have read the third entry" do
      get_data(2).type.should == :text
      get_data(2).length.should == 9
      get_data(2).value.should == 'table_one'
    end

    it "should have read the fourth entry" do
      get_data(3).type.should == :int
      get_data(3).length.should == 1
      get_data(3).value.should == "\x02"
    end

    it "should have read the fifth entry" do
      get_data(4).type.should == :text
      get_data(4).length.should == 52
      get_data(4).value.should == "CREATE TABLE table_one(id int, a_column varchar(20))"
    end

    def get_data(index)
      @database_record.entries[index]
    end

  end
end
