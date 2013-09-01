class PlayersController < ApplicationController

def new
    @player = Player.new
    @membership_types = MembershipType.all
    
  end
  
def create
	@player = Player.new(player_params)
	@player.save
	redirect_to @player
end
 
def show
  @player = Player.find(params[:id])
  @vs_players = Player.all
  @membership_type = MembershipType.find(@player.membership_type_id).membership_type
end

def index
  @players = Player.all
  @membership_types = MembershipType.all
  
  #if (!Player.membership_type_id.blank?)
	#  @membership_type = MembershipType.find(Player.membership_type_id)
  #end
end

def edit
	@player = Player.find(params[:id])
end

def update
  @player = Player.find(params[:id])
 
  if @player.update(params[:player].permit(:first_name, :last_name, :telephone, :membership_number, :admin))
    redirect_to @player
  else
    render 'edit'
  end
end

def list
   @players = Player.order(:last_name).where('lower(last_name) like ?', "%#{params[:term].downcase}%")
   @players = @players + Player.where('membership_number like ?', "%#{params[:term]}%")

    #@players = Player.all
    render json: @players.map(&:last_name)
  end
  
private
  def player_params
    params.require(:player).permit(:first_name, :last_name, :telephone, :membership_number, :membership_type_id, :admin)
  end

end
