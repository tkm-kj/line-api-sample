class MessageText < ApplicationRecord
  validates :content, presence: true
end
