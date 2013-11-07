class User < ActiveRecord::Base
  validates :user_name, uniqueness: true, presence: true

  has_many(
    :authored_polls,
    class_name: "Poll",
    foreign_key: :author_id,
    primary_key: :id
  )

  has_many(
    :responses,
    class_name: "Response",
    foreign_key: :respondent_id,
    primary_key: :id
  )

  has_many :answer_choices, through: :responses, source: :answer_choice

  def my_polls
    self.authored_polls.joins({questions: :answer_choices}).uniq
  end

end