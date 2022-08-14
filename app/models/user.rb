class User < ApplicationRecord
  has_secure_password
  has_one_attached :avatar

  attr_accessor :avatar_crop_x,
                :avatar_crop_y,
                :avatar_crop_h,
                :avatar_crop_w,
                :company,
                :project

  include ImageUploader::Attachment(:image)
end
