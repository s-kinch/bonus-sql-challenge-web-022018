# Write methods that return SQL queries for each part of the challeng here

# 1. Who did Jon Stewart have on the Daily Show the most?
def guest_with_most_appearances
  sql = <<-SQL
    SELECT guest_name FROM (
      SELECT guest_name, count(guest_name)
      FROM guests
      GROUP BY guest_name
      ORDER BY count(guest_name) DESC LIMIT 1
    );
  SQL
  DB[:conn].execute(sql)[0][0]
end

# 2. What was the most popular profession of guest for each year Jon Stewart hosted the Daily Show?
def popular_profession_by_year
  sql = <<-SQL
      SELECT year, google_knowledge_occupation, MAX(num)
      FROM (
        SELECT year, google_knowledge_occupation, COUNT(*) AS num
        FROM guests
        GROUP BY year, google_knowledge_occupation
      )
      GROUP BY year;
  SQL
  DB[:conn].execute(sql)
end

# 3. What profession was on the show most overall?
def popular_profession
  sql = <<-SQL
    SELECT google_knowledge_occupation, count(google_knowledge_occupation)
    FROM guests
    GROUP BY google_knowledge_occupation
    ORDER BY count(google_knowledge_occupation) DESC LIMIT 1;
  SQL
  DB[:conn].execute(sql)[0][0]
end

# 4. How many people did Jon Stewart have on with the first name of Bill?
def count_bills
  sql = <<-SQL
    SELECT count(*) FROM (SELECT DISTINCT guest_name FROM guests WHERE guest_name LIKE "Bill %");
  SQL
  DB[:conn].execute(sql)[0][0]
end

# 5. What dates did Patrick Stewart appear on the show?
def patrick_stewart_dates
  sql = <<-SQL
    SELECT show_date FROM guests WHERE guest_name = "Patrick Stewart";
  SQL
  DB[:conn].execute(sql)
end

# 6. Which year had the most guests?
def year_with_most_guests
  sql = <<-SQL
    SELECT year FROM guests GROUP BY year
    ORDER BY count(*) DESC LIMIT 1;
  SQL
  DB[:conn].execute(sql)[0][0]
end

# 7. What was the most popular "Group" for each year Jon Stewart hosted?
def popular_group_by_year
  sql = <<-SQL
  SELECT year, guest_group, MAX(num)
  FROM (
    SELECT year, guest_group, COUNT(*) AS num
    FROM guests
    GROUP BY year, guest_group
  )
  GROUP BY year;
  SQL
  DB[:conn].execute(sql)
end

puts "Who did Jon Stewart have on the Daily Show the most?"
puts guest_with_most_appearances
puts ""
puts "What was the most popular profession of guest for each year Jon Stewart hosted the Daily Show?"
puts popular_profession_by_year.inspect
puts ""
puts "What profession was on the show most overall?"
puts popular_profession
puts ""
puts "How many people did Jon Stewart have on with the first name of Bill?"
puts count_bills
puts ""
puts "What dates did Patrick Stewart appear on the show?"
puts patrick_stewart_dates.inspect
puts ""
puts "Which year had the most guests?"
puts year_with_most_guests
puts ""
puts "What was the most popular \"Group\" for each year Jon Stewart hosted?"
puts popular_group_by_year.inspect
