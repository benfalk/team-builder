require "#{Rails.root}/app/uploaders/avatar_uploader"

class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :summoner, presence: true

  validates :summoner_id, uniqueness: true

  validate :validate_summoner_verified, on: :create

  belongs_to :summoner
  
  has_many :champion_preferences

  has_many :role_preferences

  has_many :favorite_role_preferences, ->{ where preference: :favorite }, class_name: 'RolePreference'

  has_many :favorite_champion_preferences, ->{ where preference: :favorite }, class_name: 'ChampionPreference'

  has_many :favorite_champions, through: :favorite_champion_preferences, source: :champion

  has_many :favorite_roles, through: :favorite_role_preferences, source: :role

  mount_uploader :avatar, AvatarUploader

  def attempt_summoner_verification
    summoner.verify_account! unless summoner.nil? or summoner.verified?
  end

  def validate_summoner_verified
    return if summoner.nil?
    summoner.verify_account! unless summoner.verified? 
    errors.add(:summoner, 'could not be verified') unless summoner.verified?
  end

end
