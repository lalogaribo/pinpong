class HomeController < ApplicationController
  def index
    @users = User.order(score: :desc)
  end

  def history
  end

  def log
  end
end
