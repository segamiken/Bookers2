class Book < ApplicationRecord

	validates :title, presence: true, length: {maximum: 200}

	validates :body, presence: true, length: {maximum: 200}

	belongs_to :user
	has_many :post_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy

	def favorited_by?(user)
        favorites.where(user_id: user.id).exists?
  end


  #books controllerのindex actionで使用
   def self.search(search, search_way)
      if search && search_way == "1"
        where(['title LIKE?', "%#{search}%"])
      elsif search && search_way == "2"
        where(['title LIKE?', "#{search}%"])
      elsif search && search_way == "3"
        where(['title LIKE?', "%#{search}"])
      elsif search && search_way == "4"
        where(title: search)
      else
        all
      end
    end

end
