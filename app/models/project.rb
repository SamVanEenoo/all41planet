class Project < ApplicationRecord
  has_many :users
  has_one_attached :avatar

  attr_accessor :show_project,
                :project_logo,
                :project_logo_crop_x,
                :project_logo_crop_y,
                :project_logo_crop_h,
                :project_logo_crop_w

  include ImageUploader::Attachment(:image)
end
