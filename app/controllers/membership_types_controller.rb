class MembershipTypesController < ApplicationController

  def new
  end

  def create
  	@type = MembershipType.new(type_params)
  	if @type.save
  		redirect_to @type
  	else
  		render 'new'
  	end
  end
 
  def show
    @type = MembershipType.find(params[:id])
  end

  def edit
      @type = MembershipType.find(params[:id])
  end
    
  def index
    @types = MembershipType.all
  end
  
  def update
    @type = MembershipType.find(params[:id])
 
    if @type.update(params[:type].permit(:court_cost, :membership_cost))
      redirect_to @type
    else
      render 'edit'
    end
  end
  
  private
    def type_params
      params.require(:membershipType).permit(:membership_type, :court_cost, :membership_cost)
    end  
end
