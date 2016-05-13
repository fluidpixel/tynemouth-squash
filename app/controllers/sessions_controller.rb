class SessionsController < ApplicationController
  def new
  end
  
  def create
    player = Player.authenticate(params[:full_name], params[:membership_number])
    if player
      if player.admin
        session[:player_id] = player.id
        redirect_to bookings_path#, :notice => "Logged in!"
      else
        flash.now.alert = "Account does not have admin rights. To book a court simply click an empty court time"
        redirect_to bookings_path
      end
    else
      flash.now.alert = "Invalid Name (" + params[:full_name] + ") or membership number (" + params[:membership_number] + ")"
      render "new"
    end
  end
  
  def destroy
	  session[:player_id] = nil
	  redirect_to bookings_path, :notice => "Logged out!"
  end

end
