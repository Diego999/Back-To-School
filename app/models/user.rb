class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_and_belongs_to_many :promotions
  belongs_to :establishment
  has_many :messages
  has_many :events
  has_many :followers
  has_many :follows_promotions, :class_name => 'Promotion', through: :followers
  has_and_belongs_to_many :discussions

end
