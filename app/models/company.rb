class Company < ApplicationRecord
  has_many :users
  has_one_attached :avatar

  attr_accessor :avatar_crop_x,
                :avatar_crop_y,
                :avatar_crop_h,
                :avatar_crop_w

  include ImageUploader::Attachment(:image)
end
