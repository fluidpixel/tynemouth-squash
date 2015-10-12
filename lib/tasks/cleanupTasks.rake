namespace :archive do
  desc "Archive all inactive guest accounts"  
  task :guests => :environment do
    puts "guests:"
    Player.where('membership_type_id = 15').find_each do |guest|
    # player = Player.find(:first, :order => 'RANDOM()')
      if guest.future_bookings.count == 0 && guest.future_vs_bookings.count == 0
        puts "#{guest.full_name}"
        guest.archived = true
        guest.save
      end
    end
  end
  
  desc "Archived accounts"  
  task :list => :environment do
    puts "archived:"
    Player.where('archived = true').find_each do |player|
        puts "#{player.full_name}"
    end
  end
  
end