class Response < ActiveRecord::Base
  attr_accessible :question_id, :response
  validate :response, :presence => true

  belongs_to :question, :class_name => 'Question', :foreign_key => 'question_id', :primary_key => 'id'
  has_many :answers, :class_name => 'Answer', :foreign_key => 'response_id', :primary_key => 'id', :dependent => :destroy
end
