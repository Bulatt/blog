class Comment < ActiveRecord::Base

  belongs_to :user
  belongs_to :post

  validates :user_id, :post_id,  presence: true
  validates :body, presence: true, length: { minimum:15 }


end
