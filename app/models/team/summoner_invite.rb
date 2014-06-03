class Team::SummonerInvite < ActiveRecord::Base

  enum status: [:undecided, :declined, :accepted]

  belongs_to :team

  belongs_to :summoner

end
