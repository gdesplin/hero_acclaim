class Character < ApplicationRecord

  has_many :images, as: :imageable

end
