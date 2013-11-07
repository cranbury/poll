class Response < ActiveRecord::Base
  validates :answer_choice_id, :respondent_id, presence: true
  validate :respondent_has_not_already_answered_question

  belongs_to(
    :answer_choice,
    class_name: "AnswerChoice",
    foreign_key: :answer_choice_id,
    primary_key: :id
  )

  belongs_to(
    :respondent,
    class_name: "User",
    foreign_key: :respondent_id,
    primary_key: :id
  )

  private
  def respondent_has_not_already_answered_question
    if existing_responses.count == 1 &&
      existing_responses.first.id == respondent_id
    elsif existing_responses.empty?
    else
      errors[:response] << "Respondent has already answered question."
    end
  end

  def existing_responses
    Response.find_by_sql(["SELECT responses.id
    FROM responses
    JOIN (
      SELECT *
      FROM answer_choices
      WHERE answer_choices.question_id = (
        SELECT question_id
        FROM answer_choices
        WHERE answer_choices.id = ?)) AS j
    ON responses.answer_choice_id = j.id
    WHERE respondent_id = ?" , answer_choice_id, respondent_id])
  end

end


