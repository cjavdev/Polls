class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :respondent_id
      t.integer :response_id

      t.timestamps
    end
  end
end
