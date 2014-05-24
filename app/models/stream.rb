class Stream < ActiveRecord::Base

  has_many :notifications

  belongs_to :owner, polymorphic: true

end
