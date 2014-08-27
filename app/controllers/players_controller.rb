class PlayersController < ApplicationController

helper_method :sort_column, :sort_direction

def new
    @player = Player.new
    @membership_types = MembershipType.all
    @trial_membership = MembershipType.where(:membership_type => "trial")
end
  
def create
	@player = Player.new(player_params)
  @membership_types = MembershipType.all
  @trial_membership = MembershipType.where(:membership_type => "trial")
  
  if @player.save
  	redirect_to @player
  else
    render 'new'
  end
  
end
 
def show
  @player = Player.find(params[:id])
  @membership_type = MembershipType.find(@player.membership_type_id).membership_type
    
  @vs_bookings = Booking.where('start_time >= ?', DateTime.current).where(:vs_player_id => @player.id)
end

def index
  @players = Player.order(sort_column + " " + sort_direction)
  @membership_types = MembershipType.all
  
  #if (!Player.membership_type_id.blank?)
	#  @membership_type = MembershipType.find(Player.membership_type_id)
  #end
end

def edit
  if is_super_admin
  	@player = Player.find(params[:id])
     @membership_types = MembershipType.all
  else
    flash[:warning] = "You need to be logged in as a Super Admin to edit a player"
    @player = Player.find(params[:id])
    redirect_to @player
  end
end

def destroy
  @player = Player.find(params[:id])
  @player.destroy
 
  redirect_to players_path
end

def update
  @player = Player.find(params[:id])
 
  if @player.update(params[:player].permit(:first_name, :last_name, :membership_type_id, :landline, :mobile, :membership_number, :admin, :super_admin))
    redirect_to @player
  else
    render 'edit'
  end
end

def list
   @players = Player.order(:last_name).where('lower(last_name) like ?', "%#{params[:term].downcase}%")
   @players = @players + Player.where('membership_number like ?', "%#{params[:term]}%")
   @players = @players + Player.order(:first_name).where('lower(first_name) like ?', "%#{params[:term].downcase}%")
    #@players = Player.all
    render json: @players.map { |player| player.first_name + ' ' + player.last_name }
    #render json: @players.map(&:last_name,&:first_name)
  end
  
private
  def player_params
    params.require(:player).permit(:first_name, :last_name, :membership_number, :membership_type_id, :landline, :mobile, :admin, :super_admin, :email)
  end

  def sort_column
    Player.column_names.include?(params[:sort]) ? params[:sort] : "last_name, first_name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
  
end
