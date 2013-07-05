class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :choice_id
      t.integer :completed_survey_id
      t.integer :question_id
    end
  end
end
