class User < ApplicationRecord
  belongs_to :company
  belongs_to :projects
end
