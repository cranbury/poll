class Question < ActiveRecord::Base
  validates :text, presence: true, uniqueness: true
  validates :poll_id, presence: true

  has_many(
    :answer_choices,
    class_name: "AnswerChoice",
    foreign_key: :question_id,
    primary_key: :id
  )

  belongs_to(
    :poll,
    class_name: "Poll",
    foreign_key: :poll_id,
    primary_key: :id
  )

  has_many :respondents, through: :answer_choices, source: :respondents


  def results
    choices_with_response_counts = self
    .answer_choices
    .select("answer_choices.*, COUNT(responses.id) AS response_count")
    .joins(:responses)
    .group("answer_choices.id")

    results_hash = Hash.new
    choices_with_response_counts.each do |choice|
      results_hash[choice.text] = choice.response_count
    end
    #self.answer_choices.joins(responses: :answer_choices).where().uniq

    results_hash


  end
end
