#coding: utf-8
module BookingsHelper

def paid_link_text(booking)  
  booking.paid? ? 'Paid' : 'Pay'  
end 

def paid_link_class(booking)
  @player = Player.find(booking.player_id)
  @membership_type = MembershipType.find(@player.membership_type_id)
  
  if booking.vs_player_id
    @vsplayer = Player.find(booking.vs_player_id)
    @vs_membership_type = MembershipType.find(@vsplayer.membership_type_id)
    
    if @vs_membership_type.court_cost < @membership_type.court_cost
      @membership_type = @vs_membership_type
    end
    
  end
  
  
  booking.paid? ? 'has_paid' : 'to_pay'+ '_' + @membership_type.membership_type
end

def membership_type(booking)
  @player = Player.find(booking.player_id)
  @membership_type = MembershipType.find(@player.membership_type_id)
  
  if booking.vs_player_id
    @vsplayer = Player.find(booking.vs_player_id)
    @vs_membership_type = MembershipType.find(@vsplayer.membership_type_id)
    
    if @vs_membership_type.court_cost < @membership_type.court_cost
      @membership_type = @vs_membership_type
    end
  end
  
  @membership_type.membership_type
end

def membership_type_and_price(booking)
  
  @player = Player.find(booking.player_id)
  @membership_type = MembershipType.find(@player.membership_type_id)
  
  if booking.vs_player_id
    @vsplayer = Player.find(booking.vs_player_id)
    @vs_membership_type = MembershipType.find(@vsplayer.membership_type_id)
    
    if @vs_membership_type.court_cost < @membership_type.court_cost
      @membership_type = @vs_membership_type
    end
  end
  
  @membership_type.membership_type + ' ' + number_to_currency(@membership_type.court_cost, :unit => "£")
end

end
