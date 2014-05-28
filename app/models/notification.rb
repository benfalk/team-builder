class Notification < ActiveRecord::Base

  belongs_to :stream
  belongs_to :source, polymorphic: true

  before_create :determine_from_field

  def determine_from_field
    self.from =
      case source_type
        when 'User'
          source.summoner.name
        else
          ''
      end
  end

end
