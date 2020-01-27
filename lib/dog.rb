class Dog 
  attr_accessor :name, :breed, :id
  
  def initialize(name, breed)
    @name = name
    @breed = breed
    @id = nil
  end
end