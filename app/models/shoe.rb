class Shoe < ApplicationRecord
  belongs_to :user
  belongs_to :shoe_status
end
