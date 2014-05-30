class Team < ActiveRecord::Base

  include StreamOwner

  CUSTOM_SQL = '
    SELECT 
      game_id
      FROM games_summoners
      WHERE summoner_id IN (:summoner_list)
      GROUP BY game_id
      HAVING count(game_id) > 1'.gsub(/\n/,'')

  scope :including_membership_data, ->{ includes(team_memberships:[:user,:summoner,:role]) }

  has_many :team_memberships

  has_many :team_notes

  has_many :users, through: :team_memberships, source: :user

  has_many :summoners, through: :team_memberships, source: :summoner

  mount_uploader :avatar, AvatarUploader

  def game_ids
    Team.find_by_sql([CUSTOM_SQL, {summoner_list: team_memberships.pluck(:summoner_id)}]).map { |g| g['game_id'] }
  end

  def games
    Game.where(id: game_ids).includes(:summoners,{game_stats:[:summoner]})
  end

end
