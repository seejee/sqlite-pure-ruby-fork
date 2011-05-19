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

  end
end
