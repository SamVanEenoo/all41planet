class User < ApplicationRecord
  has_secure_password

  attr_accessor :avatar_crop_x,
                :avatar_crop_y,
                :avatar_crop_h,
                :avatar_crop_w

  include ImageUploader::Attachment(:image)
end
