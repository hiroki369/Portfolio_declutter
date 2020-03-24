class PostComment < ApplicationRecord
	belongs_to :user
	belongs_to :post
	has_many :notifications, dependent: :destroy
	validates :body, presence: true
	validates :body, length: {maximum:500}
end
