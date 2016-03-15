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
    bankholidays = Array["2016-01-01",
                         "2016-03-25",
                         "2016-03-28",
                         "2016-05-02",
                         "2016-05-30",
                         "2016-08-29",
                         "2016-12-27",
                         "2017-01-02",
                         "2017-04-14",
                         "2017-04-17",
                         "2017-05-01",
                         "2017-05-29",
                         "2017-08-28"]
                        
    date = day.in_time_zone
    bankholidays.include?(date.strftime("%Y-%m-%d"))
  end
  
  def is_closed_day(day)
    closedDays = Array["2016-12-25", "2016-12-26", "2017-01-01", "2017-12-25", "2017-12-26", "2018-01-01"]
    date = day.in_time_zone
    closedDays.include?(date.strftime("%Y-%m-%d"))
  end
  
  def mobile_device?  
    request.user_agent =~ /Mobile|webOS/  
  end  
  helper_method :mobile_device?
    
      
end
