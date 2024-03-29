class Team::MatchMaker < Struct.new(:user)

  def teams
    Team.where(
      is_not_a_member
      .and(compatable_gaming_times)
      .and(matching_play_style)
      .and(role_is_needed)
    )
  end
  
  private

  def compatable_gaming_times
    if user.gaming_times == 'all_day_everyday'
      table[:gaming_times].not_eq(nil)
    else
      table[:gaming_times].eq(:all_day_everyday).or(table[:gaming_times].eq(user.gaming_times.to_sym))
    end
  end

  def role_is_needed
    memberships = TeamMembership.arel_table
    roles = Role.arel_table
    teams = Team.arel_table
    query = 
      teams
      .project(teams[:id])
      .join(roles, Arel::Nodes::OuterJoin).on(roles[:id].in(user_roles))
      .join(memberships, Arel::Nodes::OuterJoin).on(
        roles[:id].eq(memberships[:role_id])
        .and(teams[:id].eq(memberships[:team_id]))
      )
      .where(memberships[:summoner_id].eq(nil))
    query.distinct
    team_ids = query.engine.connection.send(:select, query.to_sql, 'AREL').rows.flatten
    table[:id].in(team_ids)
  end

  def matching_play_style
    table[:play_style].eq(user.play_style)
  end

  def is_not_a_member
    table[:id].not_in(user.team_ids)
  end

  def table
    Team.arel_table  
  end

  def user_roles
    user.favorite_role_ids
  end

end
