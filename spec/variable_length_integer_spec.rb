require "rspec"

describe VariableLengthInteger do

  context "reading a single byte value" do

    before(:all) do
      setup("\x2b")
    end

    it "should have a length of 1" do
      @variable.length.should == 1
    end

    it "should have a value of 0x2b" do
      @variable.value.should == 0x2b
    end

  end

  context "reading a multiple byte value" do

    before(:all) do
      setup("\x8c\xA0\x6F")
    end

    it "should have a length of 3" do
      @variable.length.should == 3
    end

    it "should have a value of 200815" do
      @variable.value.should == 200815
    end

  end

  context "reading a -1" do

    before(:all) do
      setup("\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF")
    end

    it "should have a length of 9" do
      @variable.length.should == 9
    end

    it "should have a value of -1" do
    #  0xFFFFFFFFFFFFFFFF.should == -1

      puts "\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF".unpack('q')


      @variable.value.should == -1
    end

  end

  def setup(bytes)
    StringIO.open(bytes) do |io|
      @variable = VariableLengthInteger.new(io)
    end
  end

end