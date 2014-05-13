class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :summoner
  
  has_many :champion_preferences

  has_many :role_preferences

  has_many :favorite_role_preferences, ->{ where preference: :favorite }, class_name: 'RolePreference'

  has_many :favorite_champion_preferences, ->{ where preference: :favorite }, class_name: 'ChampionPreference'

  has_many :favorite_champions, through: :favorite_champion_preferences, source: :champion

  has_many :favorite_roles, through: :favorite_role_preferences, source: :role

end
