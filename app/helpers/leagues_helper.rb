module LeaguesHelper
  def score_for_player(player, vs_player, league)
    league.fixtures.each do |fixture|
      if fixture.playerA == player && fixture.playerB == vs_player
        return fixture.score.first
      elsif fixture.playerB == player && fixture.playerA == vs_player
        return fixture.score.second
      else
        return 0
      end
    end
  end
  
  def total_score(player, league)
    @total = 0
    
    league.fixtures.each do |fixture|
      if fixture.playerA == player
        @total = fixture.score.first.to_i + @total
      elsif fixture.playerB == player
        @total = fixture.score.second.to_i + @total
      end
    end
    
    return @total
  end
  
end
