class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_player
  helper_method :is_admin
  helper_method :is_super_admin
  helper_method :is_bank_holiday
  helper_method :is_covid_day

  before_action :set_cache_buster

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
    bankholidays = Array["2021-04-02",
                         "2021-04-05",
                         "2021-05-03",
                         "2021-05-31",
                         "2021-08-30",
                         "2021-12-27",
                         "2021-12-28",
                         "2022-01-03",
                         "2022-04-15",
                         "2022-04-18",
                         "2022-05-02",
                         "2022-06-02",
                         "2022-06-03",
                         "2022-08-29",
                         "2022-12-26",
                         "2022-12-27"]

    date = day.in_time_zone
    bankholidays.include?(date.strftime("%Y-%m-%d"))
  end

  def is_covid_day(day)
    date = day.in_time_zone.to_date
    cutoff = Date.new(2021, 6, 21).in_time_zone.to_date

    difference = (date - cutoff).to_i

    logger.info("📆 day: #{day}, #{date}, #{cutoff}, #{difference}")
    if difference < 0
      return true
    else
      return false
    end
  end

  def is_closed_day(day)
    closedDays = Array["2021-12-25",
                       "2021-12-26",
                       "2022-01-01",
                       "2022-12-25",
                       "2022-12-26",
                       "2023-01-01",
                       "2023-12-25",
                       "2023-12-26",
                       "2024-01-01",
                       "2024-12-25",
                       "2024-12-26"]
    date = day.in_time_zone
    closedDays.include?(date.strftime("%Y-%m-%d"))
  end

  def mobile_device?
    request.user_agent =~ /Mobile|webOS/
  end
  helper_method :mobile_device?


end
