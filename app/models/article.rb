class Article < ApplicationRecord
  has_many :comments
  has_many :likes

  def liked_by_user?(current_user)
    self.likes.pluck(:user_id).include?(current_user.id)
  end
end
