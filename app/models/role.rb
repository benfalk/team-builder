class Role < ActiveRecord::Base
  has_many :role_preferences
end
