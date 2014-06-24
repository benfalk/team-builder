class Endorsement < ActiveRecord::Base

  belongs_to :user

  belongs_to :skill

  validates_presence_of :user, :skill

end
