class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :trackable, :validatable
  has_many :games

  scope :opponents, ->(user) { where.not(id: user) }

  def to_s
    email.split("@").first.titleize
  end
end
