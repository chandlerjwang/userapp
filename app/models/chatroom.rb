class Chatroom < ApplicationRecord
	has_many :users, through: :messages
	has_many :messages, dependent: :destroy
	validates :topic, presence: true, uniqueness: true
end
