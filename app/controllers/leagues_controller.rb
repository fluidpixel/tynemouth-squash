class LeaguesController < ApplicationController

  def new
      @league = League.new(league_number:League.count.to_s)
      @player_count = 0
  end
  
  def create
  	@league = League.new(league_params)
  	if @league.save
      if params[:league][:players_attributes]
        params[:league][:players_attributes].each do |key, value|
          @player = Player.authenticateFullName(value[:full_name], "xxx")
          if @player
            if value[:_destroy] == "true"
              @league.players.delete(@player)
            else
              @league.players << @player              
            end
          end
        end
      end
      
      @league.players.each.with_index do |player, playerIndex|
        @league.players.each.with_index do |vsPlayer, vsIndex|
          if vsIndex <= playerIndex
            #do nothing as we don't want to set up a fixture against ourselves, or repeat an existing fixture
          else
            @fixture = Fixture.new(player_a:player, player_b:vsPlayer, start_date:Date.current, end_date:Date.current+30.days, score:Score.new())
            @fixture.save
            @league.fixtures << @fixture
          end
        end
      end
      
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
            if value[:_destroy] == "true"
              @player.league = nil
              @player.fixtures.destroy_all
            else
              
              if @player.league == @league
                #do nothign player is already in this league
              elsif @player.league
                #remove fixtures from previous league first
                @player.fixtures.destroy_all
                create_fixtures_for_player(@league, @player)
                @league.players << @player
              else
                create_fixtures_for_player(@league, @player)
                @league.players << @player
              end
              
            end
            @player.save
          end
        end
      end
      redirect_to @league and return
    end
    render 'edit'
  end
  
  def destroy
    @league = League.find_by_id(params[:id])
    
    if @league
      @league.players.clear
      # @league.fixtures.clear
      @league.destroy
    end
    
    redirect_to leagues_path
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
  
  def create_fixtures_for_player (league, new_player)
    league.players.each.with_index do |vsPlayer, playerIndex|
          @fixture = Fixture.new(player_a:new_player, player_b:vsPlayer, start_date:Date.current, end_date:Date.current+30.days, score:Score.new())
          @fixture.save
          @league.fixtures << @fixture
    end
  end
  
  def league_params
    params.require(:league).permit(:league_number, :players_attributes)
  end

  respond_to :html, :js
end
