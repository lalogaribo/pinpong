class GamesController < ApplicationController
  before_action :set_game, only: [:show]

  def index
    @games = current_user.games
  end

  def new
    @game = Game.new
  end

  def show

  end

  def create
    @game = Game.new(game_params)
    @game.user_id = current_user.id
    if @game.save
      flash[:success] = "Game was created"
      redirect_to history_path
    else
      render :new
    end
  end

  private
  def set_game
    @game = Game.find(params[:id])
  end
    def game_params
      params.require(:game).permit(:date_played, :opponent_id, :user_score, :opponent_score)
    end
end