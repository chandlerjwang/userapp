class Message < ApplicationRecord
	belongs_to :chatroom
	belongs_to :user
	scope :for_display, -> { order(:created_at).last(25) }
	mount_uploader :picture, PictureUploader
	validate :picture_size

	private
		def picture_size
			if self.picture.size > 5.megabytes
				errors.add(:picture, "should be less than 5MB")
			end
		end
end
