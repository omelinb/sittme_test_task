class Post < ApplicationRecord
  scope :page, -> (page, per_page) do
    order(:created_at).offset(page * per_page).limit(per_page)
  end
end
