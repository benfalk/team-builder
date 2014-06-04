require "#{Rails.root}/app/uploaders/avatar_uploader"

class User < ActiveRecord::Base

 include StreamOwner

 GAMING_TIME_OPTIONS = {
    'Nights & Weekends'=> 'nights_and_weekends',
    'All Day Everyday'=> 'all_day_everyday',
    'Weekends Only'=> 'weekends_only',
    'Daytime Only'=> 'daytime_only'
  }

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

  has_many :team_memberships

  has_many :favorite_role_preferences, ->{ where preference: :favorite }, class_name: 'RolePreference'

  has_many :favorite_champion_preferences, ->{ where preference: :favorite }, class_name: 'ChampionPreference'

  has_many :favorite_champions, through: :favorite_champion_preferences, source: :champion

  has_many :favorite_roles, through: :favorite_role_preferences, source: :role

  has_many :teams, through: :team_memberships, source: :team

  has_many :team_requests, class_name: 'Team::Request'

  has_many :team_invites, through: :summoner, source: :team_invites

  mount_uploader :avatar, AvatarUploader

  after_create do
    GameBuilder.perform_async(summoner_id)
  end

  def self.skype_names
    where.not(skype: [nil, '']).pluck(:skype)
  end

  def attempt_summoner_verification
    summoner.verify_account! unless summoner.nil? or summoner.verified?
  end

  def validate_summoner_verified
    return if summoner.nil?
    summoner.verify_account! unless summoner.verified? 
    errors.add(:summoner, 'could not be verified') unless summoner.verified?
  end

  def full_name
    "#{first_name} #{last_name}".squish!
  end

  def location
    "#{location_city} #{location_state}".squish!
  end

  def gaming_times_pretty
    GAMING_TIME_OPTIONS.index(gaming_times)
  end 
end
