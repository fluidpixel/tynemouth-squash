class FixturesController < ApplicationController
  
  def show
    @fixture = Fixture.find_by_id(params[:id])
  end
  
  def edit
    @fixture = Fixture.find_by_id(params[:id])
    if !@fixture.score
      @fixture.score = Score.new()
    end
  end
  
  def update
    @fixture = Fixture.find(params[:id])
 
    if @fixture.update(params[:fixture].permit(score_attributes:[:first, :second, :id]))
      redirect_to @fixture.league and return
    else
      render 'edit'
    end
    
  end
  
end