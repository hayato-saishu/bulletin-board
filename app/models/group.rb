class Group < ApplicationRecord
  belongs_to :user
  has_many :posts
  validates :comment, presence: true, length: {maximum: 255 }
end
