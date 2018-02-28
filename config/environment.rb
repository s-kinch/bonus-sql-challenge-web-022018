require 'bundler'
Bundler.require

# Setup a DB connection here
DB = {:conn => SQLite3::Database.new("db/guests.db")}
