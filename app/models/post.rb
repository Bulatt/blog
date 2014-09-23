class Post < ActiveRecord::Base

  belongs_to :user

  validates :title, presence: true, length: { minimum:10, maximum:50 }, uniqueness: true
  validates :body, presence: true,  length: { minimum:130 }

  def self.search(query)
    where("title like ?", "%#{query}%")
  end
end
