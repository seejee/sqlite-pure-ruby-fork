require "spec_helper"

describe Page do

  context "when reading the first page" do

    before(:all) do
      open_test_db do |io|
        @header = Header.new(io)
        @page   = Page.new(@header, 1, io)
      end
    end

    it "should calculate header length" do
      @page.header_length.should == 8
    end

    it "should be a table leaf node" do
      @page.type.should == :table_leaf_node
    end

    it "should read the first available offset" do
      @page.first_available.should == 0
    end

    it "should read the number of cells" do
      @page.num_cells.should == 2
    end

    it "should read the number of cells" do
      @page.content_start.should == 1873
    end

    it "should read the fragment free bytes" do
      @page.fragmented_free_bytes.should == 0
    end

  end

  context "when reading the first cell" do

    before(:all) do
      open_test_db do |io|
        @header = Header.new(io)
        @page = Page.new(@header, 1, io)
      end
    end

    it "should populate cells" do
      @page.cells.length.should == @page.num_cells
    end

    it "should read the first cells record size" do
      @page.cells[0].record_size.should == 82
    end

    it "should read the first cells key value" do
      @page.cells[0].key_value.should == 1
    end

  end


  context "when reading the second page" do

    before(:all) do
      open_test_db do |io|
        @header = Header.new(io)
        @page   = Page.new(@header, 2, io)
      end
    end

    it "should be a table leaf node" do
      @page.type.should == :table_leaf_node
    end

    it "should read the first available offset" do
      @page.first_available.should == 0
    end

    it "should read the number of cells" do
      @page.content_start.should == 2025
    end
  end
end