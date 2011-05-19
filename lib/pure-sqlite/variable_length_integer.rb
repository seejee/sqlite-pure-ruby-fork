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

        is_ninth_byte = (counter == 9)
        byte_starts_with_zero = (byte & IS_LAST_BYTE_MASK == 0)

        usable_size = is_ninth_byte ? 8 : 7

        if(usable_size == 7)
          byte &= LAST_SEVEN_BITS_MASK
        end

        value = value << usable_size
        value += byte

        if(is_ninth_byte || byte_starts_with_zero)
          break
        end

      end

      adjusted_for_twos_complement = [value].pack('q').unpack('q').first

      {
        length: counter,
        value: adjusted_for_twos_complement
      }
    end

  end
end
