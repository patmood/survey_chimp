class Answer < ActiveRecord::Base
  belongs_to :completed_survey
  belongs_to :question
  belongs_to :choice
end
