require_relative "pure-sqlite/binary_structure"
require_relative "pure-sqlite/variable_length_integer"
require_relative "pure-sqlite/database"
require_relative "pure-sqlite/header"
require_relative "pure-sqlite/page"
require_relative "pure-sqlite/table_cell"
require_relative "pure-sqlite/database_record"
require_relative "pure-sqlite/database_record_entry"

module PureSQLite
  extend self

  def list_tables(filename)
    Database.open(filename) do |db|
      db.tables
    end
  end

end
