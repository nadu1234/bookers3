class CommentReply < ApplicationRecord
  
  belongs_to :user
  belongs_to :book_comment
  
end
