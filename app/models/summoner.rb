##
# This is the user account on the Riot server
# for League of Legends and is the information
# that is bound to a user account
#
class Summoner < ActiveRecord::Base

  def self.prepare_binding(params)
    params = params[:summoner] if params[:summoner]
    params.keys.each { |k| params[k].downcase! }
    where(region: params[:region], name: params[:name]).first || new(params)
  end

  validates_presence_of :name, :region

  validate :validate_summoner_name, on: :create

  has_one :user

  has_one :stats_summary, class_name: 'Summoner::StatsSummary'

  has_many :game_stats, class_name: 'GameStats'

  before_create :create_verify_string

  after_create :fetch_riot_info, :populate_stats_summary, :boot_game_stats

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

  def fetch_riot_info
    stats = LOL::Api::Client.new.summoner_by_names(name).first.last 
    update(riot_uid: stats['id'], level: stats['summonerLevel'])
  end

  def populate_stats_summary
    build_stats_summary
    stats_summary.update_from_api!
  end

  def boot_game_stats
    GameStats.update_recent_for(self)
  end

end
