class AddRespondentIndex < ActiveRecord::Migration
  def change
    add_index :responses, :respondent_id
  end
end
