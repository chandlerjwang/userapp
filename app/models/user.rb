class User < ApplicationRecord
	before_save { self.email = email.downcase }
	has_secure_password
	validates :name, presence: true, length: { maximum: 50 }
	validates :password, presence: true, length: { minimum: 5 }

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: {maximum: 255 },
					  uniqueness: { case_sensitive: false },
					  format: { with: VALID_EMAIL_REGEX }
end
