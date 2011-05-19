module PureSQLite
  class DatabaseRecord

    attr_reader :data_types

    def initialize(record_size, stream)
      @record_length = VariableLengthInteger.new(stream)

      @data_types = []
      (1..entries).each do
        type_value = VariableLengthInteger.new(stream).value
        @data_types << get_data_type_entry(type_value)
      end
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
        else
          if(type_value.odd? && type_value > 12)
            {type: :string  , length: (type_value - 13) / 2}
          else
            {type: :blob    , length: (type_value - 12) / 2}
          end
      end
    end

    def entries
      @record_length.value
    end

  end
end