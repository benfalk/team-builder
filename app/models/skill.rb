class Skill < ActiveRecord::Base
  
  belongs_to :user

  has_many :endorsements, dependent: :destroy

  OPTIONS = [
      'Add Skill',
      'Top Lane',
      'Mid Lane',
      'Jungle',
      'AD carry',
      'Support'
  ]

end
