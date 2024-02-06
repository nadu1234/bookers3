class BookComment < ApplicationRecord
  
  belongs_to :user
  belongs_to :book
  has_many :comment_replies, dependent: :destroy
end
