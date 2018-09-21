require 'elo'
class Game < ActiveRecord::Base
  belongs_to :user
  belongs_to :opponent, class_name: 'User'
  validates_presence_of :user_id, :opponent_id
  validates :user_score, presence: {message: 'Score is needed '}, numericality: true
  validates :opponent_score, presence: {message: 'Score is needed '}, numericality: true
  validate :winner
  after_save :calculate_rating


  def result(id)
    is_user = (id == user_id)
    if is_user
      user_score > opponent_score ? "W" : "L"
    else
      opponent_score > user_score ? "W" : "L"
    end
  end

  def winner
    errors.add(:base, "Match should have a winner") unless (user_score != opponent_score)
    errors.add(:base, "Winner score should be 21 or more") unless (user_score >= 21 || opponent_score >= 21)
    errors.add(:base, "Score should have a difference of 2 or more") unless ((user_score - opponent_score).abs >= 2)
  end

  def calculate_rating
    player1 = RatedPlayer.new(user_id, user.score)
    player2 = RatedPlayer.new(opponent_id, opponent.score)
    Match.new(player1, player2, user_score > opponent_score ? 1 : 0)
    user.update_column(:score, player1.rating)
    opponent.update_column(:score, player2.rating)
  end
end
