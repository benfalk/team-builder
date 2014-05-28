class TeamNote < ActiveRecord::Base

  belongs_to :team, touch: true
  belongs_to :game

end
