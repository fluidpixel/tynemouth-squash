class CourtsController < ApplicationController
def new
end

def create
	@court = Court.new(court_params)
	if @court.save
		redirect_to @court
	else
		render 'new'
	end
end
 
def show
  @court = Court.find(params[:id])
end

def index
  @courts = Court.all
end

private
  def court_params
    params.require(:court).permit(:courtName, :timeSlots)
  end

end
