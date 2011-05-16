require 'bundler/setup'
require 'rspec'
require 'pure-sqlite'

RSpec.configure do |c|
  include PureSQLite
end

