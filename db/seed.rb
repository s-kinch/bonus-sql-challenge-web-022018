# Parse the CSV and seed the database here! Run 'ruby db/seed' to execute this code.

require 'sqlite3'
require 'csv'
require_relative '../config/environment'

sql = <<-SQL
  CREATE TABLE IF NOT EXISTS guests (
    year INTEGER,
    google_knowledge_occupation TEXT,
    show_date TEXT,
    guest_group TEXT,
    guest_name TEXT
  );
SQL
DB[:conn].execute(sql)

CSV.foreach('./daily_show_guests.csv', headers:true) do |row|
  sql = <<-SQL
    INSERT INTO guests VALUES (?, ?, ?, ?, ?)
  SQL
  DB[:conn].execute(sql, row[0], row[1], row[2], row[3], row[4])
end
