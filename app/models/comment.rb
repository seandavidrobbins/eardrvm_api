class Comment < ApplicationRecord
  belongs_to :song
  validates :username, :user_id, presence: true
end
