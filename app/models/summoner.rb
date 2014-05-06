##
# This is the user account on the Riot server
# for League of Legends and is the information
# that is bound to a user account
#
class Summoner < ActiveRecord::Base

  validates_presence_of :name, :region

  belongs_to :user

  before_create :create_verify_string

  def create_verify_string
    self.verify_string = Array.new(18){ rand(36).to_s(36) }.join
  end

  def name_found?
    LOL::Api::Client.new.summoner_by_names(name).count == 1
  end

end
