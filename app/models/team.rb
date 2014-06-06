class Team < ActiveRecord::Base

  include StreamOwner
  include GamingTimes

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

  has_many :requests, class_name: 'Team::Request'

  has_many :users, through: :team_memberships, source: :user

  has_many :summoner_invites, class_name: 'Team::SummonerInvite'

  has_many :summoners, through: :team_memberships, source: :summoner

  mount_uploader :avatar, AvatarUploader

  def game_ids
    Team.find_by_sql([CUSTOM_SQL, {summoner_list: team_memberships.pluck(:summoner_id)}]).map { |g| g['game_id'] }
  end

  def games
    Game.where(id: game_ids).includes(:summoners,{game_stats:[:summoner]})
  end

  def user_questions(user)
    UserQuestions.new(self,user)
  end

  def has_member?(user)
    return false unless user.is_a?(User)
    user_ids.include?(user.id)
  end

  def is_team_captain?(user)
    return false unless user.is_a?(User)
    team_memberships.where(membership_type: 'captain', user_id: user.id).count > 0
  end

  def level_range
    if levels.all? { |s| s == 30 }
      'all 30'
    else
      "#{levels.min} - #{levels.max}"
    end
  end

  def levels
    summoners.map { |s| s.level }
  end

  def positions
    team_memberships.map { |s| s.role.to_s }.uniq
  end

  def open_positions
    Role.full_list - positions
  end

end
