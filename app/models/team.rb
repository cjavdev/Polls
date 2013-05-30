class Team < ActiveRecord::Base
  attr_accessible :captain_id, :name
  validates :name, :presence => true, :uniqueness => true
  validates :captain_id, :presence => true

  belongs_to :captain, :class_name => "User", :foreign_key => "captain_id", :primary_key => 'user_id'
  has_many :team_users, :class_name => 'TeamUser', :foreign_key => 'team_id', :primary_key => 'id'
  has_many :users, :through => :team_users
end
