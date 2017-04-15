class User < ApplicationRecord
	attr_accessor :remember_token
	before_save { self.email = email.downcase }
	has_secure_password
	validates :name, presence: true, length: { maximum: 50 }
	validates :password, presence: true, length: { minimum: 5 }

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: {maximum: 255 },
					  uniqueness: { case_sensitive: false },
					  format: { with: VALID_EMAIL_REGEX }



	def self.digest(unencrypted_string)
		# this choose a cost param based on test or prod env
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
		
		BCrypt::Password.create(unencrypted_string, cost: cost)
	end

	def self.new_token
		SecureRandom.urlsafe_base64
	end

	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(self.remember_token))
	end

	def authenticated?(remember_token)
		BCrypt::Password.new(self.remember_digest).is_password?(remember_token)
	end

	def forget
		update_attribute(:remember_digest, nil)
	end
end
