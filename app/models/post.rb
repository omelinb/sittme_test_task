class Post < ApplicationRecord
  scope :page, -> (page, per_page) { offset(page * per_page).limit(per_page) }
end
