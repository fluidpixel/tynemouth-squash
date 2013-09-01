module BookingsHelper

def paid_link_text(booking)  
  booking.paid? ? 'Paid' : 'Pay'  
end 

def paid_link_class(booking)
  @player = Player.find(booking.player_id)
  @membership_type = MembershipType.find(@player.membership_type_id)
  
  booking.paid? ? 'has_paid' : 'to_pay'+ '_' + @membership_type.membership_type
end

end
