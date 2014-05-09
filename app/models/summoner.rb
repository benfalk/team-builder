##
# This is the user account on the Riot server
# for League of Legends and is the information
# that is bound to a user account
#
class Summoner < ActiveRecord::Base

  validates_presence_of :name, :region

  validate :validate_summoner_name, on: :create

  belongs_to :user

  has_many :game_stats, class_name: 'GameStats'

  before_create :create_verify_string

  after_create :fetch_riot_uid

  def create_verify_string
    self.verify_string = Array.new(18){ rand(36).to_s(36) }.join
  end

  def name_found?
    # TODO - Need to really push this into the API...
    LOL::Api::Client.new.summoner_by_names(name).count == 1
  rescue
    false
  end

  def validate_summoner_name
    errors.add(:name, 'Summoner name not found.') unless name_found?
  end

  private

  def fetch_riot_uid
    update(riot_uid: LOL::Api::Client.new.summoner_by_names(name).first.last['id'])
  end

end
