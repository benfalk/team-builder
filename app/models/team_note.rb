class TeamNote < ActiveRecord::Base

  belongs_to :team, touch: true
  belongs_to :game

  mount_uploader :league_replay, LeagueReplayUploader

end
