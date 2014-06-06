class Stream < ActiveRecord::Base

  has_many :notifications

  belongs_to :owner, polymorphic: true

  def self.interlaced_for(user)
    ids = where(owner_type: 'Team', owner_id: user.team_ids).pluck(:id)
    Notification.where(stream_id: ids)
  end

  def parse_game_notifications(game)
    parse_team_game_notifications(game) if owner.is_a?(Team)
  end

  private

  def parse_team_game_notifications(game)
    stats = game.game_stats.where(summoner_id: summoner_ids).to_a
    
    notifications.create message: game_message(stats),
                         notification_type: game_type(stats),
                         source: game

    stats.each do |stat|
      parse_multikills(stat).each do |info|
        notifications.create info.merge(source: game)
      end
    end
  end

  def summoner_ids
    @summoner_ids ||= owner.summoner_ids
  end

  def game_type(stats)
    stats.first.won? ? :game_won : :game_lost
  end

  def game_message(stats)
    if stats.first.won?
      "WON #{stats.first.played_at.strftime('%b %e %H:%M')}"
    else
      "LOST #{stats.first.played_at.strftime('%b %e %H:%M')}"
    end
  end

  def parse_multikills(stat)
    [].tap do |notifications|
      if stat.raw && stat.raw['stats']

        stats = stat.raw['stats']

        if stat.quadra_kills? 
          notifications << {message: "#{stat.summoner.name} picked up a QuadraKill!", notification_type: :multikill_4}
        end

        if stat.penta_kills?
          notifications << {message: "#{stat.summoner.name} picked up a PentaKill!", notification_type: :multikill_5}
        end

        if stat.triple_kills?
          notifications << {message: "#{stat.summoner.name} picked up a TripleKill!", notification_type: :multikill_3}
        end
        
      end
    end
  end


end
