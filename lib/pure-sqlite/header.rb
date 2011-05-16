module PureSQLite
  class Header

    STRUCTURE = {
      well_known_string:  { length: 16  , pattern: 'Z16'  },
      page_size:          { length: 2   , pattern: 'n'    },
      write_version:      { length: 1   , pattern: 'C'    },
      read_version:       { length: 1   , pattern: 'C'    },
    }

    def initialize(stream)
      @header = parse_header(stream)
    end

    def well_known_string
      @header[:well_known_string]
    end

    def page_size
      @header[:page_size]
    end

    def write_version
      @header[:write_version]
    end

    def read_version
      @header[:read_version]
    end

    private

    def parse_header(stream)
      hash = {}

      STRUCTURE.each do |field, opts|
        field_bytes = stream.read(opts[:length])
        hash[field] = field_bytes.unpack(opts[:pattern]).first
      end

      hash
    end

  end
end
