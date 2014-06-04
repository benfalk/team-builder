class Team::SummonerInvite < ActiveRecord::Base

  enum status: [:undecided, :declined, :accepted]

  belongs_to :team

  belongs_to :summoner

  after_save do
    team.team_memberships.create(user: summoner.user, summoner: summoner) if accepted?
  end

end
