class SessionsController < ApplicationController
  def new
  end
  
  def create
    player = Player.authenticate(params[:last_name], params[:membership_number])
    if player
      session[:player_id] = player.id
      redirect_to bookings_path, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid Name (" + params[:last_name] + ") or membership number (" + params[:membership_number] + ")"
      render "new"
    end
  end
  
  def destroy
	  session[:player_id] = nil
	  redirect_to bookings_path, :notice => "Logged out!"
  end

end
