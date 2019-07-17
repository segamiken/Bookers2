class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

   def email_required?
   	  false
   end

   def email_changed?
      false
   end

   validates :name, length: {minimum: 2, maximum: 20}

   validates :introduction, length: {maximum: 50}

   has_many :books, dependent: :destroy
   attachment :profile_image
   has_many :post_comments, dependent: :destroy
   has_many :favorites, dependent: :destroy


   has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
   has_many :followings, through: :active_relationships, source: :follower

   has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
   has_many :followers, through: :passive_relationships, source: :following

   def followed_by?(user)
     passive_relationships.find_by(following_id: user.id).present?
   end
end
