class Poll < ActiveRecord::Base
  attr_accessible :name
  validates :name, :presence => true, :uniqueness => true


  has_many :questions, :class_name => "Question", :foreign_key => 'poll_id', :primary_key => 'id'
  belongs_to :creator, :class_name => "User", :foreign_key => 'creator_id', :primary_key => 'id'

  def results
    # SELECT q.question, r.response, count(*) answer_count
#     FROM questions q
#     JOIN polls p
#     ON q.poll_id = p.id
#     JOIN responses r
#     ON r.question_id = q.id
#     JOIN answers a
#     ON a.response_id = r.id
#     WHERE p.id = 1
#     GROUP BY a.id
    self.questions.includes(:responses => :answers).each do |q|
      p q.question
      q.responses.each do |r|
        p r.response
        p r.answers.length
      end
      puts
    end
  end

  def find_creator_teams
    creator.teams
  end
end
