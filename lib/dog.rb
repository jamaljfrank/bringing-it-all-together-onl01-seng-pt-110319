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
      sql = <<-SQL
        INSERT INTO dogs (name, breed) 
       VALUES (?, ?)
      SQL

     DB[:conn].execute(sql, self.name, self.breed)
     @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs") [0][0]
    
     self
  end
  
  def self.create(attributes)
    dog = Dog.new(attributes)
    dog.save
    dog
  end
  
  def self.new_from_db(row)
    dog = self.new(name: row[1], breed: row[2], id: row[0])
    
  end
  
  def self.find_by_id(id)
    sql = <<-SQL
        SELECT * FROM dogs WHERE id = ?
        SQL

        result = DB[:conn].execute(sql, id)[0]
        self.new(id: result[0], name: result[1], breed: result[2])
      end
  
end