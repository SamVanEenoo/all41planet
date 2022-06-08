class Company < ApplicationRecord
  has_many :users
  has_one_attached :avatar

  attr_accessor :show_company,
                :company_logo,
                :company_logo_crop_x,
                :company_logo_crop_y,
                :company_logo_crop_h,
                :company_logo_crop_w

  include ImageUploader::Attachment(:image)
end
