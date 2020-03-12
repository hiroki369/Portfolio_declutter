class Post < ApplicationRecord

	belongs_to :user
	attachment :post_image
	has_many :post_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy

	def favorited?(user)
		favorites.where(user_id: user.id).exists?
	end

	def best_answerd?(post)
		post_comments.find_by(best_answer: true).present?
	end
	def self.search(search)
		return Post.all unless search
		Post.where("title LIKE?","%#{search}%")
	end

	def posted?(user)
		post_comments.where(user_id: user.id).exists?
	end
end

