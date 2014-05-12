class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :summoner
  
  has_many :champion_preferences

  has_many :favorite_champion_preferences, ->{ where preference: :favorite }, class_name: 'ChampionPreference'

  has_many :favorite_champions, through: :favorite_champion_preferences, source: :champion

  has_many :champions, through: :champion_preferences, source: :champion

end
