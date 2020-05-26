class Post < ApplicationRecord
  scope :page, -> (limit, cursor) {
    order(:created_at).where('id > ?', cursor).limit(limit)
  }
end
