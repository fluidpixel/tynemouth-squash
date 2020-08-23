#coding: utf-8
module BookingsHelper

def paid_link_text(booking)  
  booking.paid? ? 'Paid' : 'Pay'  
end 

def paid_link_class(booking)
  @player = Player.find(booking.player_id)
  @membership_type = MembershipType.find(@player.membership_type_id)
  
  if booking.vs_player_id
    @vsplayer = Player.find_by_id(booking.vs_player_id)
    if @vsplayer
      @vs_membership_type = MembershipType.find(@vsplayer.membership_type_id)
    
      if @vs_membership_type.court_cost < @membership_type.court_cost
        @membership_type = @vs_membership_type
      end
    end
  end
  
  
  booking.paid? ? 'has_paid' : 'to_pay'+ '_' + @membership_type.membership_type
end

def membership_type(booking)
  @player = Player.find(booking.player_id)
  @membership_type = MembershipType.find(@player.membership_type_id)
  
  if booking.vs_player_id
    @vsplayer = Player.find_by_id(booking.vs_player_id)
    
    if @vsplayer
      @vs_membership_type = MembershipType.find(@vsplayer.membership_type_id)
      if @vs_membership_type.court_cost < @membership_type.court_cost
        @membership_type = @vs_membership_type
      end
    end
  end
  
  @membership_type.membership_type
end

def cleaning_class(timeSlot)
  timeSlot.cleaning ? 'cleaning_row' : 'normal_row'
end

def send_to_dropbox(day)
  @daysBookings = Booking.where(Booking.arel_table[:time_slot_id].not_eq(nil)).by_day(day.to_i).order("start_time ASC")      
  Dropbox::API::Config.app_key    = ENV['DROPBOX_APPKEY']
  Dropbox::API::Config.app_secret = ENV['DROPBOX_APPSECRET']
  @client = Dropbox::API::Client.new(:token  => ENV['DROPBOX_USERTOKEN'], :secret => ENV['DROPBOX_USERSECRET'])
  @bookingDay = (Date.current + day.to_i).strftime("%d_%B_%A") + '.txt'
  
  #ac = ActionController::Base.new()
  @data = render( :template => :text_booking, :formats => [:text])
  begin
    response = @client.upload @bookingDay, @data # => #<Dropbox::API::File>
  rescue
    puts "error sending to dropbox"
  end
end

def membership_type_and_price(booking)
  
  @player = Player.find(booking.player_id)
  @membership_type = MembershipType.find(@player.membership_type_id)
  
  if booking.vs_player_id
    @vsplayer = Player.find_by_id(booking.vs_player_id)
    if @vsplayer
      @vs_membership_type = MembershipType.find(@vsplayer.membership_type_id)
    
      if @vs_membership_type.court_cost < @membership_type.court_cost
        @membership_type = @vs_membership_type
      end
    end
  end
  
  if booking.incurs_fine
    @cost = (@membership_type.court_cost + 1)
  else 
    @cost = @membership_type.court_cost
  end
  
  @membership_type.membership_type + ' ' + number_to_currency(@cost, :unit => "£")
end

end
