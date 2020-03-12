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
    bankholidays = Array["2018-05-07",
                         "2018-05-28",
                         "2018-08-27",
                         "2019-04-19",
                         "2019-04-22",
                         "2019-05-06",
                         "2019-05-27",
                         "2019-08-26",
                         "2020-04-10",
                         "2020-04-13",
                        #  "2020-05-04", no longer a bank-holiday
                         "2020-05-25",
                         "2020-08-31",
                         "2021-04-02",
                         "2021-04-05",
                         "2021-05-03",
                         "2021-05-31",
                         "2021-05-30"]

    date = day.in_time_zone
    bankholidays.include?(date.strftime("%Y-%m-%d"))
  end

  def is_closed_day(day)
    closedDays = Array["2018-01-01",
                       "2018-12-25",
                       "2018-12-26",
                       "2019-01-01",
                       "2019-12-25",
                       "2019-12-26",
                       "2020-01-01",
                       "2020-12-25",
                       "2020-12-26",
                       "2021-01-01",
                       "2021-12-25",
                       "2021-12-26",
                       "2022-01-01",
                       "2022-12-25",
                       "2022-12-26"]
    date = day.in_time_zone
    closedDays.include?(date.strftime("%Y-%m-%d"))
  end

  def mobile_device?
    request.user_agent =~ /Mobile|webOS/
  end
  helper_method :mobile_device?


end
