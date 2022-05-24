class Company < ApplicationRecord
  has_many :users

  attr_accessor :name, :vat_number, :website
end
