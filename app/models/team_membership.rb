class TeamMembership < ActiveRecord::Base

  belongs_to :user

  belongs_to :team, touch: true

  belongs_to :role

  belongs_to :summoner

  after_create :sync_user_and_summoner

  validates_presence_of :summoner

  validate :duplicate_summoner_check, on: :create

  def summoner_name
    summoner ? summoner.name : ''
  end

  def summoner_name=(name)
    summoner = Summoner.prepare_binding(name: name, region: region)
    if summoner.save
      self.summoner = summoner
      self.user = summoner.user if summoner.user
    end
    name
  end

  def sync_user_and_summoner
    update(user_id: summoner.user.id) if user_id.nil? && summoner.user.present?
  end

  def duplicate_summoner_check
    errors.add(:summoner, 'Already a member of this team') if TeamMembership.where(summoner_id: summoner_id, team_id: team_id).any?
  end

  private

  def region
    team ? team.region : 'na'
  end

end
