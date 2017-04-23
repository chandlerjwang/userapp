module ApplicationCable
  class Connection < ActionCable::Connection::Base
  	include SessionsHelper

  	identified_by :message_user

  	def connect
  		self.message_user = get_current_message_user
  	end

  	private

  		def get_current_message_user
  			if !current_message_user.nil?
  				current_message_user
  			else
  				reject_unauthorized_connection	
        end
  		end
  end
end
