class TeamMembership < ActiveRecord::Base

  belongs_to :user

  belongs_to :team

  belongs_to :role

  belongs_to :summoner

end
