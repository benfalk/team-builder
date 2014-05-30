module GoldPerMinuteCalculations

  FREE_GOLD_PER_MINUTE = 114 # 19g per 10 second (Summoners Rift)
  TOP_GOLD_PER_MINUTE = 500 # (Summoners Rift by Faker)
  TOP_EARNABLE_GOLE_PER_MINUTE = TOP_GOLD_PER_MINUTE - FREE_GOLD_PER_MINUTE

  extend ActiveSupport::Concern

  included do
    cattr_accessor(:gold_per_minute_field){ :gold_per_minute }
  end


  def earned_gold_per_minute
    _gpm - FREE_GOLD_PER_MINUTE
  end
  
  def gold_per_minute_percentage
    (earned_gold_per_minute / TOP_EARNABLE_GOLE_PER_MINUTE.to_f * 100).floor
  end

  private

  def _gpm
    [send(gold_per_minute_field),FREE_GOLD_PER_MINUTE].max
  end

end
