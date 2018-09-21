class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :trackable, :validatable
  has_many :games
  has_many :games_challenged, foreign_key: "opponent_id", class_name: "Game"

  scope :opponents, ->(user) { where.not(id: user) }

  def to_s
    email.split("@").first.titleize
  end

  def games_played
    games + games_challenged
  end
end
