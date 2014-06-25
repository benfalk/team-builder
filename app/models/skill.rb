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
      'juggernaut',
      'Mind Reader',
      'Long Shot',
      'Farm, farm, farm',
      'Great Attitude',
      'Ultimate disrespect',
      'Made me laugh',
      'encourager',
      'Good Advice',
      'tasteful humor',
      'Want on my team',
      'Good communicator',
      'Lane Freezing',
      'Proxying',
      'Map awareness',
      'Streamer',
      'Lane Synergy'
  
  ]

end
