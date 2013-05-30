class User < ActiveRecord::Base
  attr_accessible :name
  validates :name, :presence => true, :uniqueness => true

  has_many :team_users, :class_name => 'TeamUser', :foreign_key => 'user_id', :primary_key =>'id'
  has_many :teams, :through => :team_users
  has_many :captained_teams, :class_name => 'Team', :foreign_key => 'captain_id', :primary_key =>'id'
  has_many :polls, :class_name => 'Poll', :foreign_key => 'creator_id', :primary_key =>'id'
  has_many :answers, :class_name => 'Answer', :foreign_key => 'respondent_id', :primary_key => 'id'

  def all_answers

    all_answers = answers.includes(:response => [{:question => :poll}])

    puts "something"
    all_answers.each do |answer|
      puts "#{answer.response.question.poll.name} - #{answer.response.question.question} - #{answer.response.response}"
    end
  end
end
