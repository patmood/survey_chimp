require 'faker'

prime = User.create({
              name: "Ted",
              email: "mrawesome@sauce.com",
              password: "password"
            })


5.times do
  10.times do
    user = User.create(name: Faker::Name.name, email: Faker::Internet.email, password: "password")
  end
  1.times do
    survey = prime.surveys.create(title: Faker::Lorem.words(3).join(" "))
    10.times do
      question = survey.questions.create(content: "#{Faker::Lorem.sentence(1).chop}?")
      4.times do
        question.choices.create(content: Faker::Lorem.words(1).join(" "))
      end
    end
  end
end

#Make all the users take all the surveys
User.all.each do |user|
  Survey.all.each do |survey|
    comp_survey = user.completed_surveys.create(survey_id: survey.id)
    survey.questions.all.each do |question|
      choice =  question.choices.all.sample
      comp_survey.answers.create(question_id: question.id, choice_id: choice.id)
    end
  end
end

