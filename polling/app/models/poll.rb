class Poll < ActiveRecord::Base
  validates :title, uniqueness: true, presence: true
  validates :author, presence: true

  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :author_id,
    primary_key: :id
  )

  has_many(
    :questions,
    class_name: "Question",
    foreign_key: :poll_id,
    primary_key: :id
  )

  has_many :respondents, through: :questions, source: :respondents
  has_many :answer_choices, through: :questions, source: :answer_choices
end
