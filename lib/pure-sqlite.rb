require_relative "pure-sqlite/binary_structure"
require_relative "pure-sqlite/variable_length_integer"
require_relative "pure-sqlite/header"
require_relative "pure-sqlite/page"
require_relative "pure-sqlite/table_cell"
require_relative "pure-sqlite/database_record"

module PureSqlite
  extend self

  def list_tables(stream)
    header   = PureSQLite::Header.new(stream)
    page_one = PureSQLite::Page.new(header, 1, stream)

    tables = []
    page_one.cells.each {|c| tables << c.database_record.data[1][:value] }
    tables
  end

end
