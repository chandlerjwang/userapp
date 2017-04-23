class Message < ApplicationRecord
	belongs_to :chatroom
	belongs_to :user
	scope :for_display, -> { order(:created_at).last(25) }
end
