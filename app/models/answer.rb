class Answer < ActiveRecord::Base
  attr_accessible :respondent_id, :response_id
  validates :respondent_id, :presence => true
  validates :response_id, :presence => true

  belongs_to :response, :class_name => "Response", :foreign_key => 'response_id', :primary_key => 'id'
  belongs_to :respondent, :class_name => "User", :foreign_key => 'respondent_id', :primary_key => 'id'

  before_save :question_not_already_answered?
  before_save :respondent_is_not_creator?
  before_save :respondent_is_on_poll_team?

  def question_not_already_answered?
    puts "Did this user already answer this question?"
    Answer.joins(:response => :question)
          .where('questions.id = ? AND respondent_id = ?', response.question.id, respondent_id)
          .empty?
  end

  def respondent_is_not_creator?
    puts "Is this respondent the creator?"
    Poll.joins(:questions => :responses)
        .where('responses.id = ?', response_id)
        .first.creator_id != respondent_id
  end

  def respondent_is_on_poll_team?
    puts "Is this respondent on the same team that created the poll?"

    respondent_teams = respondent.teams.to_a  #teams1
    creator_teams = response.question.poll.creator.teams.to_a#teams2

    respondent_teams.each do |team|
      puts "accessing teams"
      return true if creator_teams.include?(team)
    end
    false

    #loop for include

    # Poll.joins(
    #   :questions=>[
    #     :responses=> [
    #       :answers => [
    #         :respondent=>:teams]]])
    #    .joins(:creator => :teams)
    #    .where('teams.id = teams_users.id') #teams -> respondent's teams, teams_users -> creator's teams
    #    .where('polls.id = ?',response.question.poll.id)
    #    .where('users.id = ?',respondent_id)
    #    .empty?

    # poll = Poll.includes(:creator => :teams).joins(:questions => :responses).where('responses.id = ?', response_id)
#
#     my_teams = Team.includes(:users).where('users.id = ?', respondent_id)
#     poll.first.creator.teams.each do |team|
#       my_teams.each do |my_team|
#         return true if my_team.id = team.id
#       end
#     end
#     false
#
#     Poll.joins('teams a JOIN teams b ON ')

    # SELECT *
    # FROM teams poll_team
    # JOIN teams answer_team
    # ON poll_team.id = answer_team.id
    # JOIN team_users poll_team_users
    # ON poll_team_users.team_id = poll_team.id
    # JOIN team_users answer_team_users
    # ON answer_team_users.team_id = answer_team.id
    # JOIN polls
    # ON polls.creator_id = poll_team_users.user_id
    # WHERE polls.id = 1
    # AND answer_team_users.user_id = 3
  end
end
#
# SELECT COUNT(*) FROM "polls"
# INNER JOIN "questions" ON "questions"."poll_id" = "polls"."id"
# INNER JOIN "responses" ON "responses"."question_id" = "questions"."id"
# INNER JOIN "answers" ON "answers"."response_id" = "responses"."id"
# INNER JOIN "users" ON "users"."id" = "answers"."respondent_id"
# INNER JOIN "team_users" ON "team_users"."user_id" = "users"."id"
# INNER JOIN "teams" ON "teams"."id" = "team_users"."team_id"
# INNER JOIN "users" "creators_polls" ON "creators_polls"."id" = "polls"."creator_id"
# INNER JOIN "team_users" "team_users_users_join" ON "team_users_users_join"."user_id" = "creators_polls"."id"
# INNER JOIN "teams" "teams_users" ON "teams_users"."id" = "team_users_users_join"."team_id"
# WHERE (polls.id = 1) AND (users.id = 3)
