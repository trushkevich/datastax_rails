class Person < DatastaxRails::Base
  self.column_family = "people"
  
  has_one :job
  has_many :cars, :dependent => :destroy
  has_and_belongs_to_many :hobbies
  
  key :uuid
  text :name, :sortable => true
  date :birthdate
  string :nickname
  
  before_save :set_nickname
  after_save :set_variable
  
  validates :name, :presence => true, :uniqueness => :true
  
  def set_nickname
    self.nickname ||= self.name
  end
  
  def set_variable
    @after_save_ran = "yup"
  end
end

class Car < DatastaxRails::Base
  self.column_family = "cars"
  
  belongs_to :person
  
  key :uuid
  string :name
  string :person_id
end

class Job < DatastaxRails::Base
  self.column_family = "jobs"
  
  belongs_to :person
  
  key :uuid
  string :title
  string :person_id
end

class Boat < DatastaxRails::Base
  self.column_family = "boats"
  
  key :uuid
  string :name
end

class Hobby < DatastaxRails::Base
  self.column_family = "hobbies"
  
  has_and_belongs_to_many :people
  
  key :uuid
  string :name
  float :complexity
end