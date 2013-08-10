class PlayersController < ApplicationController

def new
    @player = Player.new
  end
  
def create
	@player = Player.new(player_params)
	@player.save
	redirect_to @player
end
 
def show
  @player = Player.find(params[:id])
end

def index
  @players = Player.all
end

def edit
	@player = Player.find(params[:id])
end

def update
  @player = Player.find(params[:id])
 
  if @player.update(params[:player].permit(:first_name, :last_name, :tel, :membership_number, :admin))
    redirect_to @player
  else
    render 'edit'
  end
end
private
  def player_params
    params.require(:player).permit(:first_name, :last_name, :tel, :membership_number, :admin)
  end

end
