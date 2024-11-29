class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  broadcasts_to :post  
end
