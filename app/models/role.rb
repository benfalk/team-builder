class Role < ActiveRecord::Base

  has_many :role_preferences

  def to_s
    name
  end

end
