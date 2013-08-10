class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_player
  helper_method :is_admin
  
  private
  
  def current_player
   if (session[:player_id])
    @current_player ||= Player.find(session[:player_id]) if session[:player_id]
    end
  end
  
  def is_admin
  if (session[:player_id])
   if current_player.admin
   	@is_admin ||= current_player
   	end
   end
   end
  
end
