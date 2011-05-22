require "spec_helper"

describe Header do

  before(:all) do
    open_test_db_stream do |io|
      @header = Header.new(io)
    end
  end

  it "should consist of 100 bytes" do
    @header.length.should == 100
  end

  it "should read the magic string" do
    @header.well_known_string.should == "SQLite format 3"
  end

  it "should read the page size" do
    @header.page_size.should == 2048
  end

  it "should read the write version" do
    @header.write_version.should == 1
  end

  it "should read the read version" do
    @header.read_version.should == 1
  end

  it "should read the unused bytes at the end of each page" do
    @header.page_unused_bytes.should == 0
  end

  it "should read the maximum index fraction" do
    @header.maximum_index_fraction.should == 64
  end

  it "should read the minimum index fraction" do
    @header.minimum_index_fraction.should == 32
  end

  it "should read the minimum table fraction" do
    @header.minimum_table_fraction.should == 32
  end

  it "should read the file change counter" do
    @header.file_change_counter.should == 7
  end

  it "should read the database size" do
    @header.database_size.should == 0
  end

  it "should read the first freelist trunk page" do
    @header.first_freelist_trunk_page.should == 0
  end

  it "should read the number of free pages" do
    @header.number_of_free_pages.should == 0
  end

  it "should read the schema version" do
    @header.schema_version.should == 2
  end

  it "should read the schema layer file format" do
    @header.schema_layer_file_format.should == 1
  end

  it "should read the default pager cache size" do
    @header.default_pager_cache_size.should == 0
  end

  it "should read the largest root page number" do
    @header.largest_root_page_number.should == 0
  end

  it "should read the text encoding" do
    @header.text_encoding.should == 1
  end

  it "should read the user cookie value" do
    @header.user_cookie.should == 0
  end

  it "should read the vacuum mode" do
    @header.incremental_vacuum_mode.should == 0
  end

  it "should read version valid for" do
    @header.version_valid_for.should == 0
  end

  it "should read version number" do
    @header.sqlite_version_number.should == 0
  end

end