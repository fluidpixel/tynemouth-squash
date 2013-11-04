class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_player
  helper_method :is_admin
  helper_method :is_super_admin
  helper_method :is_bank_holiday
  
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
  
  def is_super_admin
    if (session[:player_id])
      if current_player.super_admin
      	@is_super_admin ||= current_player
    	end
    end
  end
    
  def is_bank_holiday(day)
    bankholidays = Array["2013-12-25", "2013-12-26", "2014-01-01", "2014-04-18", "2014-04-21", "2014-05-05", "2014-05-26"]
    date = day.to_time
    bankholidays.include?(date.strftime("%Y-%m-%d"))
  end
      
end
