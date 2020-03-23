class Post < ApplicationRecord

	belongs_to :user
	attachment :post_image
	has_many :post_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
	has_many :notifications, dependent: :destroy
	validates :title, presence: true
	validates :title, length: {maximum:50}
	validates :body, presence: true
	validates :body, length: {maximum:350}

	def create_notification_favorite(current_user)
    # いいねされているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ", current_user.id, user_id, id, 'favorite'])
    # いいねされていない場合レコード作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: 'favorite'
      )
      # 自分の投稿に対するいいねの場合は、通知済みにする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end


    def create_notification_post_comment(current_user, comment_id)
      # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
      temp_ids = PostComment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
      temp_ids.each do |temp_id|
        save_notification_post_comment(current_user, comment_id, temp_id['user_id'])
      end
      # まだ誰もコメントしていない場合は、投稿者に通知を送る
      save_notification_post_comment(current_user, comment_id, user_id) if temp_ids.blank?
    end

    def save_notification_post_comment(current_user, post_comment_id, visited_id)
     #コメントは複数回することが考えられるため、１つの投稿に複数回通知する
      notification = current_user.active_notifications.new(
      post_id: id,
      post_comment_id: post_comment_id,
      visited_id: visited_id,
      action: 'comment'
      )

     #自分の投稿に対するコメントの場合は、通知済みとする(使わない)
      if notification.visitor_id == notification.visited_id
      notification.checked = true
       end
      notification.save if notification.valid?
    end

    # def create_notification_post_comment_best_answer(current_user,comment_id)
    #   temp_ids = PostComment.select(:user_id).where(post_id: id).where(best_answer: true).where.not(user_id: current_user.id).distinct
    #   temp_ids.each do |temp_id|
    #     save_notification_post_comment_best_answer(current_user, comment_id, temp_id['user_id'])
    #     binding.pry
    #   end
    # end

    # def save_notification_post_comment_best_answer(current_user,post_comment_id,visited_id,best_answer)

    #   notification = current_user.active_notifications.new(
    #   post_id: id,
    #   post_comment_id: post_comment_id,
    #   visited_id: visited_id,
    #   best_answer: best_answer,
    #   action: 'best_answer'
    #   )

    # end



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

