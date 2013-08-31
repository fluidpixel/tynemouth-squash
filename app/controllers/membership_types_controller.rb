class MembershipTypesController < ApplicationController

private
  def type_params
    params.require(:membershipType).permit(:membership_type, :court_cost, :membership_cost)
  end
    
    
end