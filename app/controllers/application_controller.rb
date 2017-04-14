class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def new
  	render html: "welcome - site is still being developed...check back later!"
  end
end
