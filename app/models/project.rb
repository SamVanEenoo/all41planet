class Project < ApplicationRecord
  has_many :users

  attr_accessor :name, :description, :website
end
