class Notification < ActiveRecord::Base

  belongs_to :stream
  belongs_to :source, polymorphic: true

end
