class SessionsController < ApplicationController
  def new
  end
  
  def create
    player = Player.authenticate(params[:lastName], params[:membershipNumber])
    if player
      session[:player_id] = player.id
      redirect_to bookings_path, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid Name (" + params[:lastName] + ") or membership number (" + params[:membershipNumber] + ")"
      render "new"
    end
  end
  
  def destroy
	  session[:player_id] = nil
	  redirect_to bookings_path, :notice => "Logged out!"
  end

end
