require_relative "../config/environment.rb"
require 'pry'


class Student
 attr_accessor :name, :grade
 attr_reader :id

 def initialize(name, grade, id=nil)
   @name = name
   @grade = grade
   @id = id
 end

 def self.create_table
   sql = <<-SQL
     CREATE TABLE IF NOT EXISTS students(
       id INTEGER PRIMARY KEY,
       name TEXT,
       grade INTEGER
       )
   SQL

   DB[:conn].execute(sql)
 end

 def self.drop_table
   sql = 'DROP TABLE IF EXISTS students'
   DB[:conn].execute(sql)
 end

 def save
   if self.id
     self.update
   else
     sql = 'INSERT INTO students(name, grade) VALUES(?,?)'
     DB[:conn].execute(sql, self.name, self.grade)
     @id = DB[:conn].execute('SELECT last_insert_rowid() FROM students')[0][0]
   end
 end

 def self.create(name, grade)
   student = self.new(name, grade)
   student.save
 end

 def self.new_from_db(row)
   student = self.new(row[1], row[2], row[0])
   student
 end

 def self.find_by_name(name)
   sql = 'SELECT name FROM students WHERE name = ?'
   binding.pry

   student = DB[:conn].execute
 end

end
