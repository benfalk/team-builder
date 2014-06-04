class Role < ActiveRecord::Base

  has_many :role_preferences

  def to_s
    name
  end

  def self.full_list
    @full_list ||= all.pluck(:name)
  end

end
