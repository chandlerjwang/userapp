class User < ApplicationRecord
	attr_accessor :remember_token, :activation_token, :reset_token
	has_many :chatrooms, through: :messages
	has_many :messages
	before_save :downcase_email
	before_create :create_activation_digest
	has_secure_password
	validates :name, presence: true, length: { maximum: 50 }
	validates :password, presence: true, length: { minimum: 5 },
										  allow_nil: true

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

	def authenticated?(attribute, token)
		digest = self.send("#{attribute}_digest")
		BCrypt::Password.new(digest).is_password?(token)
	end

	def send_activation_email
		UserMailer.account_activation(self).deliver_now
	end

	def activate
		update_columns(activated: true, activated_at: Time.zone.now)
	end

	def create_reset_digest
		self.reset_token = User.new_token
		update_attribute(:reset_digest, User.digest(self.reset_token))
		update_attribute(:reset_sent_at, Time.zone.now)
	end

	def send_password_reset_email
		UserMailer.password_reset(self).deliver_now
	end

	# Returns true if a password reset has expired.
	def password_reset_expired?
		self.reset_sent_at < 2.hours.ago
	end	

	private

		def create_activation_digest
			self.activation_token = User.new_token
			self.activation_digest = User.digest(self.activation_token)
		end

		def downcase_email
			self.email = email.downcase
		end
end
