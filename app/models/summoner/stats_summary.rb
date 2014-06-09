class Summoner::StatsSummary < ActiveRecord::Base

  belongs_to :summoner

  serialize :raw, Array

  def update_from_api!
    stats = LOL::Api::Client.new(region: summoner.region).stats_summary_by_id(summoner.riot_uid)['playerStatSummaries']
    update(raw: stats)
  end

end
