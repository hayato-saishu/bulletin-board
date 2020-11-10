class Group < ApplicationRecord
  belongs_to :user
  
  validates :comment, presence: true, length: {maximum: 255 }
end
