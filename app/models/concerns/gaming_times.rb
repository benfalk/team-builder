module GamingTimes

  extend ActiveSupport::Concern

  GAMING_TIME_OPTIONS = {
    'Nights & Weekends'=> 'nights_and_weekends',
    'All Day Everyday'=> 'all_day_everyday',
    'Weekends Only'=> 'weekends_only',
    'Daytime Only'=> 'daytime_only'
  }

  def gaming_times_pretty
    GAMING_TIME_OPTIONS.key(gaming_times)
  end 

end
