class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
   devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

   has_many :posts, dependent: :destroy
   has_many :post_comments, dependent: :destroy
   has_many :favorites,dependent: :destroy
   attachment :profile_image
   has_many :relationships
   has_many :followings, through: :relationships, source: :follow
   has_many :followed, class_name: 'Relationship', foreign_key: 'follow_id'
   has_many :followers, through: :followed, source: :user
   validates_uniqueness_of :email, conditions: -> { with_deleted }
   validates_uniqueness_of :name
   validates :name, length: {minimum: 2, maximum: 20}
   validates :introduction, length: { maximum: 240}
   has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
   has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy


   def create_notification_follow(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

# FBログイン用

  def self.find_for_oauth(auth)
      user = User.where(uid: auth.uid, provider: auth.provider).first

      unless user
          user = User.create(
          uid:      auth.uid,
          provider: auth.provider,
          email:    auth.info.email,
          name:  auth.info.name,
          password: Devise.friendly_token[0, 20],
        )
      end

      user
  end

def follow(other_user)
	unless self == other_user
		self.relationships.find_or_create_by(follow_id: other_user.id)
	end
end


def unfollow(other_user)
	relationship = self.relationships.find_by(follow_id: other_user.id)
	relationship.destroy if relationship
end

def following?(other_user)
	self.followings.include?(other_user)
end

def self.search(search)
    return User.all unless search
    User.where("name LIKE?","%#{search}%")
end

def rank
  ranks = User.all.order(best_answer_count:"DESC").map{ |rank| rank[:id]}
  return ranks.find_index(self.id) + 1
end


acts_as_paranoid

end
