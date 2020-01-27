class Dog 
  attr_accessor :name, :breed, :id
  
  def initialize(name:, breed:, id: nil)
    @name = name
    @breed = breed
    @id = id
  end
  
  def self.create_table
    sql =  <<-SQL
      CREATE TABLE dogs (
        id INTEGER PRIMARY KEY,
        name TEXT,
        breed TEXT
        )
        SQL
    DB[:conn].execute(sql)
  end
  
  def self.drop_table
    sql = "DROP TABLE IF EXISTS dogs"
    DB[:conn].execute(sql)
  end
  
  def save
    if self.id
      sql = "UPDATE dogs SET name = ?, grade = ? WHERE id = ?"
      DB[:conn].execute(sql, self.name, self.grade, self.id)
    else
      sql = <<-SQL
        INSERT INTO students (name, grade) 
       VALUES (?, ?)
      SQL

      DB[:conn].execute(sql, self.name, self.grade)
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
    end
end