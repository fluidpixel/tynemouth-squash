class LeaguesController < ApplicationController

  def new
      @league = League.new
  end
  
  def create
  	@league = League.new(league_params)
  	if @league.save
  		redirect_to @league
  	else
  		render 'new'
  	end
  end
  
  def show
    @league = League.find(params[:id])
  end
  
  def edit
  	@league = League.find(params[:id])
    @player_count = 0
  end
  
  def update
    @league = League.find(params[:id])
 
    if @league.update(params[:league].permit(:league_number, :players_attributes))
      if params[:league][:players_attributes]
        params[:league][:players_attributes].each do |key, value|
          @player = Player.authenticateFullName(value[:full_name], "xxx")
          if @player
              @player.league_id = params[:id]
              @player.save
          end
        end
      end
      redirect_to @league and return
    end
    render 'edit'
  end
  
  def index
    @leagues = League.all.order(:league_number)
  
    # @players = Player.order(sort_column + " " + sort_direction)
    @membership_types = MembershipType.all
  
    #if (!Player.membership_type_id.blank?)
  	#  @membership_type = MembershipType.find(Player.membership_type_id)
    #end
  end

private
  def league_params
    params.require(:league).permit(:league_number, :players_attributes)
  end

  respond_to :html, :js
end
