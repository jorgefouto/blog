class Book < ApplicationRecord

  #it makes sure that there is a title before saving to the database, so we dont get a NIL record, and book.save wont work
  validates :title, presence: true, length: { minimum: 3, maximum: 50 }
  validates :description, presence: true, length: { minimum: 10, maximum: 300 }


  # class Person < ApplicationRecord
  #   validates :name, presence: true
  # end
  # Person.create(name: "John Doe").valid? # => true
  # Person.create(name: nil).valid? # => false


end
