class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_player
  helper_method :is_admin
  helper_method :is_super_admin
  helper_method :is_bank_holiday
  
  before_filter :set_cache_buster
  
  private
  
  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
  
  def current_player
   if (session[:player_id])
    @current_player ||= Player.find(session[:player_id]) if session[:player_id]
    end
  end
  
  def is_admin
  if (session[:player_id])
   if current_player.admin || current_player.super_admin
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
    bankholidays = Array["2014-01-01", 
                        "2014-04-18", 
                        "2014-04-21", 
                        "2014-05-05", 
                        "2014-05-26", 
                        "2014-08-25", 
                        "2014-12-25", 
                        "2014-12-26", 
                        "2015-04-03", 
                        "2015-04-06",
                        "2015-05-04",
                        "2015-05-25",
                        "2015-08-31",
                        "2015-12-25",
                        "2015-12-28"]
                        
    date = day.in_time_zone
    bankholidays.include?(date.strftime("%Y-%m-%d"))
  end
  
  def is_closed_day(day)
    closedDays = Array["2014-12-25", "2014-12-26", "2015-01-01"]
    date = day.in_time_zone
    closedDays.include?(date.strftime("%Y-%m-%d"))
  end
  
  def mobile_device?  
    request.user_agent =~ /Mobile|webOS/  
  end  
  helper_method :mobile_device?
    
      
end
