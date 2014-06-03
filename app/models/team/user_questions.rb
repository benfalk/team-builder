class Team::UserQuestions
  
  def initialize(team,user)
    @team = team
    @user = user
  end

  def is_member?
    @is_member ||= @team.user_ids.include?(user_id)
  end

  def is_team_captain?
    @team.team_memberships.where(membership_type: 'captain', user_id: user_id).count == 1
  end

  def has_request_pending?
    Team::Request.undecided.where(user_id: user_id).count > 0
  end

  private

  def user_id
    @user.is_a?(User) ? @user.id : nil
  end

end
