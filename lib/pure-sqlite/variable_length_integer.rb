module PureSQLite
  class VariableLengthInteger

    IS_LAST_BYTE_MASK = 0b10000000
    LAST_SEVEN_BITS_MASK = 0b01111111

    attr_reader :length, :value

    def initialize(stream)
      result = parse(stream)

      @length = result[:length]
      @value = result[:value]
    end

    private

    def parse(stream)
      counter = 0
      value   = 0

      while(true)
        byte = stream.readbyte()

        value    = value << 7
        value   += byte & LAST_SEVEN_BITS_MASK
        counter += 1

        if(byte & IS_LAST_BYTE_MASK == 0)
          break
        end

      end

      {
        length: counter,
        value: value
      }
    end

  end
end
