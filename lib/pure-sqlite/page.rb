module PureSQLite
  class Page

    STRUCTURE = BinaryStructure.new(
        page_flag:              { length: 1, pattern: 'C' },
        first_available:        { length: 2, pattern: 'n' },
        num_cells:              { length: 2, pattern: 'n' },
        content_start:          { length: 2, pattern: 'n' },
        fragmented_free_bytes:  { length: 1, pattern: 'C' }
    )

    STRUCTURE.keys.each do |field|
      define_method(field) do
        @page_header[field]
      end
    end

    attr_reader :number, :cells

    def initialize(header, number, stream)
      @header       = header
      @number       = number
      @page_header  = read_page_header(stream)
      @cells        = read_cells(stream)
    end

    def header_length
      STRUCTURE.length
    end

    def type
      case page_flag
        when 0x2 then :index_internal_node
        when 0xA then :index_leaf_node
        when 0x5 then :table_internal_node
        when 0xD then :table_leaf_node
      end
    end

    private

    def read_page_header(stream)
      move_to_page_start(stream)
      STRUCTURE.parse(stream)
    end

    def move_to_page_start(stream)
      seek = page_offset
      seek += 100 if @number == 1
      stream.seek(seek, IO::SEEK_SET)
    end

    def page_offset
      @header.page_size * (number - 1)
    end

    def read_cells(stream)
      cells = []
      next_cell_start = page_offset + content_start

      (1..num_cells).each do
        stream.seek(next_cell_start, IO::SEEK_SET)

        cell = TableCell.new(stream)
        cells << cell

        next_cell_start += cell.total_size
      end

      cells
    end


  end
end