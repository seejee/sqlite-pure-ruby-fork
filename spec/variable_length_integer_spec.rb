require "rspec"

describe VariableLengthInteger do

  context "reading a single byte value" do

    before(:all) do
      StringIO.open("\x2b") do |io|
        @variable = VariableLengthInteger.new(io)
      end
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
      StringIO.open("\x8c\xA0\x6F") do |io|
        @variable = VariableLengthInteger.new(io)
      end
    end

    it "should have a length of 3" do
      @variable.length.should == 3
    end

    it "should have a value of 200815" do
      @variable.value.should == 200815
    end

  end

end