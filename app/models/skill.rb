class Skill < ActiveRecord::Base
  
  belongs_to :user

  has_many :endorsements, dependent: :destroy

  OPTIONS = [
      'Add Skill',
      'Top Lane',
      'Mid Lane',
      'Jungle',
      'AD carry',
      'Support',
      'Map Awareness',
      'Peeling',
      'Ganking',
      'Juggernaut',
      'Mind Reader',
      'Long Shot',
      'Farm, Farm, Farm',
      'Great Attitude',
      'Ultimate Disrespect',
      'Made Me Laugh',
      'Encouraging',
      'Good Advice',
      'Tasteful Humor',
      'Want On My Team',
      'Good Communicator',
      'Last Hitting',
      'Lane Freezing',
      'Proxying',
      'Split Pushing',
      'Streamer',
      'Lane Synergy',
      'Tower Diving',
      'Jungle Times',
      'Warding',
      'Saved My Ass',
      'Team Carrier'



  ]

end
