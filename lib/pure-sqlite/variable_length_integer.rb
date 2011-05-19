module PureSQLite
  class VariableLengthInteger

    attr_reader :length, :value

    def initialize(stream)
      result  = parse(stream)
      @length = result[:length]
      @value  = result[:value]
    end

    private

    IS_LAST_BYTE_MASK = 0b10000000
    LAST_SEVEN_BITS_MASK = 0b01111111

    def parse(stream)
      counter = 0
      value   = 0

      while(true)
        byte = stream.readbyte()
        counter += 1

        #hit the 9th byte before finding terminating byte, must be neg
        if(counter == 9)
          value = value << 8
          value += byte
          break;
        end

        #found the terminating byte
        if(byte & IS_LAST_BYTE_MASK == 0)
          value = value << 7
          value += byte
          break
        end

        #handle a non terminating byte
        value = value << 7
        value += byte & LAST_SEVEN_BITS_MASK

      end

      {
        length: counter,
        value: [value].pack('q').unpack('q').first
      }
    end

  end
end
