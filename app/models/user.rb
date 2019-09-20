class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

   #名前でログイン可能にする
   def email_required?
   	  false
   end
   def email_changed?
      false
   end

   validates :name, length: {minimum: 2, maximum: 20}
   validates :introduction, length: {maximum: 50}
   attachment :profile_image
   has_many :books, dependent: :destroy
   has_many :post_comments, dependent: :destroy
   has_many :search_histories, dependent: :destroy

   #いいね機能
   has_many :favorites, dependent: :destroy

   def followed_by?(user)
     passive_relationships.find_by(following_id: user.id).present?
   end


   #follow follwer機能
   has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
   has_many :followings, through: :active_relationships, source: :follower

   has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
   has_many :followers, through: :passive_relationships, source: :following


   #検索機能
   def self.search(search, search_way)
      if search && search_way == "1"
        where(['name LIKE?', "%#{search}%"])
      elsif search && search_way == "2"
        where(['name LIKE?', "#{search}%"])
      elsif search && search_way == "3"
        where(['name LIKE?', "%#{search}"])
      elsif search && search_way == "4"
        where(name: search)
      else
        all
      end
    end
end
