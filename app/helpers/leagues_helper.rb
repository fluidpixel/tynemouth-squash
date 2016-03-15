module LeaguesHelper
  
  def score_for_player(player, vs_player, league)
    league.fixtures.each do |fixture|
      if fixture.player_a == player && fixture.player_b == vs_player
        if fixture.score != nil
          return fixture.score.first
        else
          return 0
        end
      elsif fixture.player_b == player && fixture.player_a == vs_player
        if fixture.score != nil
          return fixture.score.second
        else
          return 0
        end
      end
    end
  end
  
  def fixture_for_player(player, vs_player, league)
    league.fixtures.each do |fixture|
      if fixture.player_a == player && fixture.player_b == vs_player
        return fixture.id
      elsif fixture.player_b == player && fixture.player_a == vs_player
        return fixture.id
      end
    end
  end
  
  def total_score(player, league)
    @total = 0
    league.fixtures.each do |fixture|
      if fixture.player_a == player
        if fixture.score != nil
          @total = fixture.score.first.to_i + @total
        end
      elsif fixture.player_b == player
        if fixture.score != nil
          @total = fixture.score.second.to_i + @total
        end
      end
    end
    
    return @total
  end
  
end
