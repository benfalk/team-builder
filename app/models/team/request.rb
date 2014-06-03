class Team::Request < ActiveRecord::Base

  enum status: [:undecided, :declined, :accepted]

  belongs_to :team

  belongs_to :user

  after_save do
    team.team_memberships.create(user: user, summoner: user.summoner) if accepted?
  end

end
