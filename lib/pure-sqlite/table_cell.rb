module PureSQLite
  class TableCell

    attr_reader :data_record_position, :database_record

    def initialize(stream)
      @record_size = VariableLengthInteger.new(stream)
      @key_value = VariableLengthInteger.new(stream)
      @database_record = DatabaseRecord.new(record_size, stream)
    end

    def total_size
      @record_size.length + @key_value.length + record_size
    end

    def record_size
      @record_size.value
    end

    def key_value
      @key_value.value
    end

  end
end