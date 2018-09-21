module GamesHelper
  def score(game)
    "#{game.user_score} - #{game.opponent_score}"
  end
end