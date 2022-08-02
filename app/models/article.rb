class Article < ApplicationRecord
  has_many :comments
  has_many :likes

  has_one_attached :image_data

  def liked_by_user?(current_user)
    self.likes.pluck(:user_id).include?(current_user.id)
  end
end
