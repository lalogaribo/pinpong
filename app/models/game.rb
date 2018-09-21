class Game < ActiveRecord::Base
  belongs_to :user
  belongs_to :opponent, class_name: 'User'
  validates_presence_of :user_id, :opponent_id
  validates :user_score, presence: {message: 'Score is needed '},
            numericality: {greater_than: 0, less_than: 22, message: " Score should be less than 21"}
  validates :opponent_score, presence: {message: 'Score is needed '},
            numericality: {greater_than: 0, less_than: 22, message: " Score should be less than 21"}
  before_save :winner


  def result(id)
    is_user = (id == user_id)
    if is_user
      user_score > opponent_score ? "W" : "L"
    else
      opponent_score > user_score ? "W" : "L"
    end
  end

  def winner
    true unless user_score > opponent_score && user_score >= 21
    true unless user_score < opponent_score && opponent_score >= 21
    else
    errors.add(:base, "A valid winner with 21 should exist")
    false
  end
end

# def winner
#   if user_score >= 21
#     true if user_score > opponent_score
#   elsif opponent_score >= 21
#     true if user_score < opponent_score
#   end
# else
#   errors.add(:base, "A valid winner with 21 should exist")
#   false
# end