require "spec_helper"

describe DatabaseRecord do

  context "when reading the first page" do

    before(:all) do
      open_test_db do |io|
        header = Header.new(io)
        page = Page.new(header, 1, io)
        cell = page.cells.first
        @database_record = cell.database_record
      end
    end

    it "should have a 7 entries" do
      @database_record.entries.should == 7
    end

    it "should have a first data type of string with length 5" do
      get_data_type(0)[:type].should == :string
      get_data_type(0)[:length].should == 5
    end

    it "should have a second data type of string with length 9" do
      get_data_type(1)[:type].should == :string
      get_data_type(1)[:length].should == 9
    end

    it "should have a third data type of string with length 9" do
      get_data_type(2)[:type].should == :string
      get_data_type(2)[:length].should == 9
    end

    it "should have a fourth data type of int with length 5" do
      get_data_type(3)[:type].should == :int
      get_data_type(3)[:length].should == 1
    end

    it "should have a fifth data type of string with length 58" do
      get_data_type(4)[:type].should == :string
      get_data_type(4)[:length].should == 58
    end

    it "should have a sixth data type of blob with length 52" do
      get_data_type(5)[:type].should == :blob
      get_data_type(5)[:length].should == 52
    end

    it "should have a seventh data type of blob with length 52" do
      get_data_type(6)[:type].should == :string
      get_data_type(6)[:length].should == 42
    end

    def get_data_type(index)
      @database_record.data_types[index]
    end

  end
end
