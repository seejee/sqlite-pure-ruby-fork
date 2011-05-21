module PureSQLite
  module Structures

    class DatabaseRecordEntry

      def initialize(stream)
        @header = VariableLengthInteger.new(stream)
        @data   = get_data_type_entry(@header.value)
      end

      def header_length
        @header.length
      end

      def length
        @data[:length]
      end

      def value
        @data[:value]
      end

      def type
        @data[:type]
      end

      def populate_value(stream)
        @data[:value] = get_value(stream)
      end

      private

      def get_value(stream)
        bytes = stream.read(length)
        bytes.unpack("A#{length}").first
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
end