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
  
  desc "Remove non-renewed accounts"
  task :non_renewed => :environment do
    puts "non-renewed:"
    removeList.each do |member_id|
      member = Player.where("membership_number = ?", member_id).first
      if member != nil
        if member.bookings_after(Date.today - 3.months).count == 0 && member.future_vs_bookings.count == 0 && member.archived == false
          puts "#{member.full_name}"
          member.archived = true
          member.save
        end
      end
    end
  end
  
  def removeList
    return ["Corp01",
    "C050",
    "C048",
    "Co037",
    "Co038",
    "Co055",
    "Co056",
    "S279",
    "S197",
    "S608",
    "S022",
    "S532",
    "S872",
    "S025",
    "S924",
    "S954",
    "S107",
    "S344",
    "S949",
    "S985",
    "S962",
    "S990",
    "S947",
    "S358",
    "S896",
    "S127",
    "S249",
    "S250",
    "S251",
    "S253",
    "S254",
    "S255",
    "S256",
    "S258",
    "S265",
    "S289",
    "S357",
    "S359",
    "S583",
    "S914",
    "S917",
    "S979",
    "Gym06",
    "Gym07",
    "Gym12",
    "J413",
    "J411",
    "J002",
    "J203",
    "J188",
    "J452",
    "J463",
    "J462",
    "J461",
    "J396",
    "J123",
    "J416",
    "J417",
    "J003",
    "J406",
    "J466",
    "J467",
    "R053",
    "R058",
    "R042",
    "R054",
    "R061",
    "R063",
    "R064",
    "R065",
    "R067",
    "R068",
    "NP292",
    "NP102",
    "NP196",
    "NP226",
    "NP249",
    "NP250",
    "NP252",
    "NP253",
    "NP270",
    "NP275",
    "NP280",
    "NP381",
    "NP927",
    "IS043",
    "IS102",
    "IS048",
    "IS044",
    "IS045",
    "IS047",
    "IS049",
    "IS052",
    "T147"]
  end
end