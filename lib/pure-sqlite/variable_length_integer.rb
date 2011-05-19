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

        if(byte & IS_LAST_BYTE_MASK == 0)
          is_last = true
          shift   = 7
        elsif(counter == 9)
          is_last = true
          shift   = 8
        else
          is_last = false
          shift   = 7
          byte    &= LAST_SEVEN_BITS_MASK
        end

        value    = value << shift unless counter == 1
        value   += byte

        if(is_last)
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
