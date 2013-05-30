class Question < ActiveRecord::Base
  attr_accessible :poll_id, :question
  validates :question, :presence => true, :uniqueness => true

  belongs_to :poll, :class_name => 'Poll', :foreign_key => 'poll_id', :primary_key =>'id'
  has_many :responses, :class_name =>'Response', :foreign_key =>'question_id', :primary_key =>'id', :dependent => :destroy
end
