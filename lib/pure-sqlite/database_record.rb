module PureSQLite
  class DatabaseRecord

    def initialize(record_size, stream)
      @entries = VariableLengthInteger.new(stream)
    end

    def entries
      @entries.value
    end

  end
end