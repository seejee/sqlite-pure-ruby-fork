module PureSQLite
  class Page

    STRUCTURE = BinaryStructure.new(
        page_flag:  { length: 1, pattern: 'C' }
    )

    STRUCTURE.keys.each do |field|
      define_method(field) do
        @page[field]
      end
    end

    attr_reader :number

    def initialize(header, number, stream)
      @header = header
      @number = number
      @page   = read_page(stream)
    end

    def type
      case page_flag
        when 13 then :table_leaf_node
      end
    end

    private

    def read_page(stream)
      move_to_page_start(stream)
      STRUCTURE.parse(stream)
    end

    def move_to_page_start(stream)
      seek = @header.page_size * (number - 1)
      seek += 100 if @number == 1
      stream.seek(seek, IO::SEEK_SET)
    end


  end
end