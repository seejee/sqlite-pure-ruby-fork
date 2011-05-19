require "spec_helper"

describe Page do

  context "when reading the first page" do

    before(:all) do
      open_test_db do |io|
        @header = Header.new(io)
        @page = Page.new(@header, 1, io)
      end
    end

    it "should be a table leaf node" do
      @page.type.should == :table_leaf_node
    end

  end

end