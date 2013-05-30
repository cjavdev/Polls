class CreateIndices < ActiveRecord::Migration
  def change
    add_index :answers, :response_id, :name => 'response_id_idx'
    add_index :answers, :respondent_id
    add_index :polls, :creator_id
    add_index :questions, :poll_id, :name => 'poll_id_idx'
    add_index :responses, :question_id
    add_index :team_users, :user_id
    add_index :team_users, :team_id
    add_index :teams, :captain_id


  end
end
