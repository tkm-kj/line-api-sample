class Message < ApplicationRecord
  belongs_to :sendable, polymorphic: true
  belongs_to :receivable, polymorphic: true
  belongs_to :resource, polymorphic: true

  delegate :content, to: :resource
end
