class Team < ActiveRecord::Base

  scope :including_membership_data, ->{ includes(team_memberships:[:user,:summoner,:role]) }

  has_many :team_memberships

  has_many :users, through: :team_memberships, source: :user

end
