module PureSQLite
  class DatabaseRecord

    attr_reader :data

    def initialize(stream)
      @header_index  = VariableLengthInteger.new(stream)
      @data          = get_data(stream)
    end

    def header_index_length
      @header_index.length
    end

    def total_header_bytes
      @header_index.value
    end

    private

    def get_data(stream)
      data = get_data_types(stream)
      populate_values(stream, data)
      data
    end

    def populate_values(stream, data)
      data.each do |hash|
        hash[:value] = get_value(stream, hash[:length])
      end
    end

    def get_value(stream, length)
      bytes = stream.read(length)
      bytes.unpack("A#{length}").first
    end

    def get_data_types(stream)
      types = []
      bytes_remaining = total_header_bytes - header_index_length

      until(bytes_remaining == 0)
        type_header = VariableLengthInteger.new(stream)
        type_value = type_header.value

        types << get_data_type_entry(type_value)

        bytes_remaining -= type_header.length
      end

      types
    end

    def get_data_type_entry(type_value)
      case(type_value)
        when 0 then {type: :null  , length: 0}
        when 1 then {type: :int   , length: 1}
        when 2 then {type: :int   , length: 2}
        when 3 then {type: :int   , length: 3}
        when 4 then {type: :int   , length: 4}
        when 5 then {type: :int   , length: 6}
        when 6 then {type: :int   , length: 8}
        when 7 then {type: :float , length: 8}
        when 8 then {type: :int   , length: 0}
        when 9 then {type: :int   , length: 0}
        else get_complex_data_type(type_value)
      end
    end

    def get_complex_data_type(type_value)
      if(type_value.odd? && type_value > 12)
        {type: :text, length: (type_value - 13) / 2}
      else
        {type: :blob, length: (type_value - 12) / 2}
      end
    end

  end
end